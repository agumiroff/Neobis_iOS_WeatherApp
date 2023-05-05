//
//  MainScreenViewModel1.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

protocol WeatherViewModel: AnyObject {
    
    var weatherData: WeatherModel? { get }
    
    var location: LocationModel? { get }
    
    var state: BehaviorRelay<WeatherViewController.WeatherState> { get }
    
    func handleEvent(event: WeatherViewController.WeatherEvent)
}

