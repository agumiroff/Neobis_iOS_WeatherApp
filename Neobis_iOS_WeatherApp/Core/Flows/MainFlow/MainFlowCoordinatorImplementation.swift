//
//  MainFlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


class MainFlowCoordinatorImplementation<N>: AppCoordinator<N> where N: MainFlowNavigation {
    
    private var module: ModuleFactory
    
    private let disposeBag = DisposeBag()
    
    init(
        moduleFactory: ModuleFactory,
        navigationController: N) {
            
            self.module = moduleFactory
            super.init(navigationController: navigationController)
            
    }
    
    override func start() {
        super.start()
        
        showSearchScreen()
    }

}

extension MainFlowCoordinatorImplementation: MainFlowCoordinator {
    
    //    func finish
    //    showMainScreen
    func showMainScreen(data: WeatherModel?, location: LocationModel) {
        let vc = module.buildMainScreen(coordinator: self, data: data, location: location)
        navigationController?.viewControllers = [vc]
    }
    
    func showSearchScreen() {
        let vc = module.buildDetailScreen(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
