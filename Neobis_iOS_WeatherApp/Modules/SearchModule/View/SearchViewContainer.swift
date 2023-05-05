//
//  SearchViewContainer.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
import UIKit
import RxSwift

class SearchViewContainer: UIView {
    
    private let loadedView = SearchLoadedView()
    
    private let errorView = SearchErrorView()
    
    private let loadingView = LoadingScreen()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        addSubview(loadedView)
        addSubview(errorView)
        addSubview(loadingView)
        
        loadedView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render(state: SearchViewController.State) {
        switch state.status {
        case .initial, .loaded:
            errorView.isHidden = true
            loadingView.isHidden = true
            loadedView.isHidden = false
            loadedView.render(cities: state.context.cities)
        case .loading:
            errorView.isHidden = true
            loadingView.isHidden = false
            loadedView.isHidden = true
        case .failure:
            errorView.isHidden = false
            loadingView.isHidden = true
            loadedView.isHidden = true
        
        }
    }
}

extension SearchViewContainer {
    
    var event: Observable<SearchViewController.Event> {
        Observable.merge(
            loadedView.event
                .map({ event in
                    switch event {
                    case .none:
                        return .none
                    case let .showCities(value: data):
                        return .showCities(value: data)
                    case let .showWeather(state: state):
                        return .showWeather(state: state)
                    case .pop:
                        return .pop
                    }
                }),
            
            errorView.event
                .map({ event in
                    switch event {
                    case .none:
                        return .none
                    case .retry:
                        return .showCities(value: "")
                    }
                })
        )
    }
}
