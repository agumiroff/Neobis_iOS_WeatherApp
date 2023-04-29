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
    
    var weatherData: WeatherModel?
    
    var state: RxRelay.BehaviorRelay<State> = BehaviorRelay(value: .initial)
    
    func searchDidTap() {
        state.accept(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.state.accept(.success)
        })
    }
    
    func setState(state: State) {
        self.state.accept(state)
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.state.accept(.failure)
        })
    }
    
    func viewAskedForTransition() {
        coordinator?.showSearchScreen()
    }
    
    func viewAskedForLoading() {
        coordinator?.showLoader()
        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
            self.setState(state: .success)
        })
    }
    
    func searchCity(name: String) {
        coordinator?.showSearchScreen()
    }
    
}

enum State {
    case initial
    case loading
    case success
    case failure
}
