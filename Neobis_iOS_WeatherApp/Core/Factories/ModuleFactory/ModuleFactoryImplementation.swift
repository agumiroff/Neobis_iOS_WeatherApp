//
//  MainFactoryImplementation.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class ModuleFactoryImplementation: ModuleFactory {
    
    func buildMainScreen() -> (UIViewController, MainScreenViewModel) {
        let view = MainScreenViewController()
        let viewModel = MainScreenViewModel(view: view)
        view.viewModel = viewModel
        return (view, viewModel)
    }
    
    func buildDetailScreen() -> (UIViewController, DetailViewModel) {
        let view = DetailViewController()
        let viewModel = DetailViewModel(view: view)
        view.viewModel = viewModel
        return (view, viewModel)
    }
}
