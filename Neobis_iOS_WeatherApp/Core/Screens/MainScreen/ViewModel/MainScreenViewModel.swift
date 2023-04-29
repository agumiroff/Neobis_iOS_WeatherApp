//
//  MainScreenViewModel1.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 28.04.2023.
//

import Foundation
import RxCocoa
import RxSwift

protocol MainScreenViewModel: AnyObject {
    
    var state: BehaviorRelay<State> { get }
    
    var weatherData: WeatherModel? { get }
    
    func searchDidTap()
    
    func setState(state: State)
    
    func viewAskedForTransition()
    
    func viewAskedForLoading()
    
    func searchCity(name: String)
}
