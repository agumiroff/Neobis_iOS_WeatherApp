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
    
    
    
    var networkService: NetworkService?
    
    var cities: RxRelay.BehaviorRelay<[LocationModel]> = BehaviorRelay(value: [])
    
    var data = [LocationModel]()
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType?
    
    func viewDidLoad() {
        
    }
    
    func searchCall(call: String) {
        
        networkService?.getCoordinatesByLocationName(location: call, completion: { [weak self] result in
            switch result {
            case .success(let data):
                self?.cities.accept(data)
                print(data)
            case .failure(let error):
                print(error)
            }
        })
    }
    
    func pop() {
        coordinator?.pop()
    }
    
    func locationDidTap(location: LocationModel) {
        networkService?.getWeatherData(location: location, completion: { [weak self] model in
            self?.coordinator?.showMainScreen(data: model, location: location)
        })
    }
    
}
