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
    
    private let disposeBag = DisposeBag()
    
    override init(navigationController: N) {
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
        
        var state: WeatherViewController.WeatherState = .initial
        
        guard let data = data else { return }
        
        if data.list.isEmpty {
            state = .error
        } else {
            state = .success
        }
        let vc = WeatherModuleBuilder.buildWeatherModule(
            coordinator: self,
            data: data,
            location: location,
            state: state
        )
        
        navigationController?.viewControllers = [vc]
    }
    
    func showSearchScreen() {
        let vc = SearchModuleBuilder.buildSearchModule(coordinator: self)
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
}
