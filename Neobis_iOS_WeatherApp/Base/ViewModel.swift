//
//  ViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import RxSwift


class ViewModel<CoordinatorType> {
    
    var coordinator: CoordinatorType?
    var state: State = .initial
    
}



