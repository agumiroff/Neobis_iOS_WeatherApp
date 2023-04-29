//
//  MainFlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class MainFlowCoordinatorImplementation<N>: AppCoordinator<N> where N: MainFlowNavigation {
    
    private var module: ModuleFactory
    
    init(moduleFactory: ModuleFactory, navigationController: N) {
        self.module = moduleFactory
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        super.start()
        selectScreenToShow()
    }
    
    private func selectScreenToShow() {
        // check dataBase if there stored data from last call
        showSearchScreen()
    }
}

extension MainFlowCoordinatorImplementation: MainFlowCoordinator {
    
    //    func finish
    //    showMainScreen
    func showMainScreen(data: WeatherModel, location: LocationModel) {
        //write properties to storage
        let vc = module.buildMainScreen(coordinator: self, data: data, location: location)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showSearchScreen() {
        let vc = module.buildDetailScreen(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func showLoader() {
        
    }
    
    func pop() {
        navigationController?.popViewController(animated: false)
    }
}
