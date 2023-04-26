//
//  DetailViewModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    func viewDidLoad()
}

class DetailViewModel: ViewModel<DetailViewController>, DetailViewModelProtocol {
    
    var text = ""
    
    func viewDidLoad() {
        view?.label.text = self.text
    }
}
