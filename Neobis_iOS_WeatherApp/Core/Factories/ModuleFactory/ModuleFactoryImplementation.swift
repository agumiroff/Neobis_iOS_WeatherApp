//
//  MainFactoryImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class ModuleFactoryImplementation: ModuleFactory {
    
    func buildMainScreen(coordinator: MainFlowCoordinatorProtocol) -> UIViewController {
        let viewModel = MainScreenViewModel()
        viewModel.coordinator = coordinator
        let view = MainScreenViewController()
        view.viewModel = viewModel
        return view
    }
    
    func buildDetailScreen(coordinator: MainFlowCoordinatorProtocol) -> UIViewController {
        _ = DetailViewModel()
        let view = DetailViewController()
        
        return view
    }
}
