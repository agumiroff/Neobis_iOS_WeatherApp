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
    
    func searchCall(call: String)
    
    var cities: BehaviorRelay<[LocationModel]> { get }
    
    var state: BehaviorRelay<State> { get }
    
    func viewDidLoad()
    
    func locationDidTap(location: LocationModel) async
    
    func cancelSearch()
}
