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
        networkService?.getCoordinatesByLocationName(location: call, completion: {
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
    
    private func showWeather(location: LocationModel) {
        
        networkService?.getWeatherData(location: location, completion: { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.coordinator.showMainScreen(
                        data: data,
                        location: location
                    )
                case .failure(let error):
                    print(error)
                }
            }
            
        })
        
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
            showWeather(location: state.context.location)
        case let .showCities(value: value):
            searchCall(call: value)
        case .pop:
            cancelSearch()
        }
    }
}

//Task.init(operation: {
//    let model = try? await self.networkService?.getWeatherData(location: location) //do try catch?
//    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//        self.coordinator?.showMainScreen(data: model, location: location)
//        self.state.accept(.success)
//    })
//})
