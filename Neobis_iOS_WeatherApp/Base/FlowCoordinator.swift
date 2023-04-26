//
//  FlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol FlowCoordinatorProtocol: AnyObject {
    func start()
}

class FlowCoordinator<Navigation: FlowNavigationProtocol>: FlowCoordinatorProtocol {
    
    weak var navigation: Navigation?
    
    init(navigation: Navigation) {
        self.navigation = navigation
        navigation.coordinator = self
    }
    
    func start() {}
    
}
