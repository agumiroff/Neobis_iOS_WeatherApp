//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

class MainScreenViewModel: ViewModel<MainFlowCoordinatorProtocol> {
    
    var state1: Observable<State> = .just(.initial)
    
    func searchDidTapped() {
        state1 = .just(.loading)
    }
    
    func configure() {
    
    }
}

    enum State {
        case initial
        case loading
        case success
        case failure
    }
