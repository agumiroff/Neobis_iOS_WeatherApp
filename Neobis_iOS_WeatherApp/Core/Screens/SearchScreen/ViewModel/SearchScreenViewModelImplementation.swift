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
    
    var state: RxRelay.BehaviorRelay<State> = BehaviorRelay(value: .initial)
        
    var networkService: NetworkService?
    
    var cities: RxRelay.BehaviorRelay<[LocationModel]> = BehaviorRelay(value: [])
    
    var data = [WeatherModel]()
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType?
    
    func viewDidLoad() {
        
    }
    
    func searchCall(call: String) {
        networkService?.getCoordinatesByLocationName(location: call, completion: {
            [weak self] result in
            switch result {
            case .success(let data):
                self?.cities.accept(data)
            case .failure(let error):
                self?.state.accept(.failure)
                print(error)
            }
        })
    }
    
    
    func locationDidTap(location: LocationModel) {
        self.state.accept(.loading)
        networkService?.getWeatherData(location: location, completion: { [weak self] model, result in
            switch result {
            case .failure:
                self?.state.accept(.failure)
            case .success:
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    self?.coordinator?.showMainScreen(data: model, location: location)
                    self?.state.accept(.success)
                })
            }
        })
    }
    
    func cancelSearch() {
        coordinator?.pop()
    }
}
