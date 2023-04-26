//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol MainScreenViewModelProtocol {
    
    var didEnterCity: ((_ data: String) -> Void)? { get set }
    var mainState: MainState { get }
    func viewDidRequestGoNext(name: String)
}

//MARK: - View Model

class MainScreenViewModel: ViewModel<MainScreenViewController>, MainScreenViewModelProtocol {
    
    var mainState: MainState = .initial
    
    var didEnterCity: ((String) -> Void)?
}

//MARK: - View methods

extension MainScreenViewModel {
    
    func viewDidLoad() {
        
    }
    
    func viewDidRequestGoNext(name: String) {
        didEnterCity?(name)
    }
    
}

enum MainState {
    
    case initial
    case loading
    case success
    case failure
    
}
