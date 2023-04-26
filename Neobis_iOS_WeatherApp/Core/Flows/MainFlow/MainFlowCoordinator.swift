//
//  MainFlowCoordinator.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class MainFlowCoordinator: FlowCoordinator<MainFlowNavigation> {
    private var module: ModuleFactory
    
    init(module: ModuleFactory, navigation: MainFlowNavigation) {
        self.module = module
        super.init(navigation: navigation)
    }
    
    override func start() {
        super.start()
        navigation?.pushViewController(mainScreen(), animated: false)
    }
    
    private func mainScreen() -> UIViewController {
        let (vc, viewModel) = module.buildMainScreen()
        
        viewModel.didEnterCity = { str in vc.navigationController?.pushViewController(self.detailScreen(text: str), animated: true)}
        
        return vc
    }
    
    private func detailScreen(text: String) -> UIViewController {
        let (vc, viewModel) = module.buildDetailScreen()
        
        viewModel.text = text
        
        return vc
    }
}
