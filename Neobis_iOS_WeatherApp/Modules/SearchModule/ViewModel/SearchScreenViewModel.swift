//
//  SearchScreenViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol SearchScreenViewModel {
    
    var cities: [LocationModel] { get }
    
    var state: BehaviorRelay<SearchViewController.State> { get }
    
    func handleEvent(event: SearchViewController.Event)
}
