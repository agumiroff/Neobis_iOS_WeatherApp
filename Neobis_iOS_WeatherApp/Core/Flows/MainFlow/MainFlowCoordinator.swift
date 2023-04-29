//
//  MainCoordinatorProtocol.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation

protocol MainFlowCoordinator: Coordinator {
    
    func showMainScreen(data: WeatherModel, location: LocationModel)
    
    func showSearchScreen()
    
    func showLoader()
    
    func pop()
}
