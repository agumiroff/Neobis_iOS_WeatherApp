//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

class MainScreenViewModelImplementation: ViewModel, MainScreenViewModel {
    
    typealias CoordinatorType = MainFlowCoordinator
    var coordinator: CoordinatorType?
    
    var location: LocationModel?
    
    var weatherData: WeatherModel?
    
    var state: BehaviorRelay<State> = BehaviorRelay(value: .initial)
     
    func searchCity() {
        state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: { [weak self] in
            self?.coordinator?.showSearchScreen()
            self?.state.accept(.success)
        })
    }
    
    func viewDidLoad() {
        if location != nil && weatherData != nil {
            self.state.accept(.success)
        } else {
            self.state.accept(.failure)
        }
    }
}


