//
//  MainScreenFabricProtocol.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

protocol ModuleFactory {
    
    func buildMainScreen(coordinator: MainFlowCoordinator,
                         data: WeatherModel?,
                         location: LocationModel) -> UIViewController
    
    func buildDetailScreen(coordinator: MainFlowCoordinator) -> UIViewController
    
}
