//
//  MainFlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class MainFlowCoordinator: FlowCoordinator<FlowNavigation> {
    
    private var module: ModuleFactory
    
    init(moduleFactory: ModuleFactory, navigation: FlowNavigation) {
        self.module = moduleFactory
        super.init(navigation: navigation)
    }
    
    override func start() {
        super.start()
        showMainScreen()
    }
    
}

extension MainFlowCoordinator: MainFlowCoordinatorProtocol {
    
    //    func finish
    //    showMainScreen
    func showMainScreen() {
        let vc = module.buildMainScreen(coordinator: self)
        navigation?.pushViewController(vc, animated: false)
    }
    
    func showDetailScreen() {
        let vc = module.buildDetailScreen(coordinator: self)
        navigation?.pushViewController(vc, animated: false)
    }
}
