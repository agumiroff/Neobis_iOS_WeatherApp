//
//  ViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

class ViewModel<V: View> {
    
    weak var view: V?
    
    init(view: V) {
        self.view = view
    }
}
