//
//  MainScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol MainScreenViewModelProtocol {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
}
