//
//  View.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol ViewController: AnyObject { //ViewModelable?
    
    associatedtype ViewModelType
    var viewModel: ViewModelType? { get set }
    
}
