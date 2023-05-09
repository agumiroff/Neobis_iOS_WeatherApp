//
//  DetailViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

class SearchScreenViewModelImplementation: SearchScreenViewModel, ViewModel {
    
    var state: RxRelay.BehaviorRelay<SearchViewController.State> = BehaviorRelay(value: .init(context: SearchViewController.Context(), status: .initial))
    
    var networkService: NetworkService?
    
    var cities = [LocationModel]()
    
    var data = [WeatherModel]()
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType
    
    init(
        coordinator: CoordinatorType
    ) {
        self.coordinator = coordinator
    }
    
    private func searchCall(call: String) {
        try? networkService?.getCoordinatesByLocationName(location: call, completion: {
            [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.state.accept(.init(context: .init(cities: data), status: .loaded))
                case .failure(let error):
                    self?.state.accept(.init(context: SearchViewController.Context(), status: .failure))
                    print(error)
                }
            }
        })
    }
    
    private func showWeather(location: LocationModel) async {
            guard let weather = try? await networkService?.getWeatherData(location: location)
            else { return }
        await MainActor.run {
            coordinator.showMainScreen(data: weather, location: location)
        }
    }
    
    private func cancelSearch() {
        coordinator.pop()
    }
    
    func handleEvent(event: SearchViewController.Event) {
        switch event {
        case .none:
            break
        case let .showWeather(state):
            self.state.accept(.init(context: SearchViewController.Context(), status: .loading))
            Task {
                await showWeather(location: state.context.location)
            }
        case let .showCities(value: value):
            searchCall(call: value)
        case .pop:
            cancelSearch()
        }
    }
}
