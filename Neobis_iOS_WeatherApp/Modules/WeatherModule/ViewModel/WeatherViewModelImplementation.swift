//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

class WeatherViewModelImplementation: ViewModel, WeatherViewModel {
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType
    
    var weatherData: WeatherModelDomain?
    
    var state: BehaviorRelay<WeatherViewController.WeatherState> = BehaviorRelay(value: .initial)
    
    init(
        coordinator: CoordinatorType,
        weatherData: WeatherModelDomain
    ) {
        self.coordinator = coordinator
        self.weatherData = weatherData
        
        state.accept(weatherData.list.isEmpty ? .error : .success)
    }
    
}

extension WeatherViewModelImplementation {
    
    func handleEvent(event: WeatherViewController.WeatherEvent) {
        state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            switch event {
            case .searchSelected:
                self?.coordinator.showSearchScreen()
            }
            self?.state.accept(.initial)
        })
    }
}

