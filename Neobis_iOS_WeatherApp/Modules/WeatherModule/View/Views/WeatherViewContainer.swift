//
//  MainViewContainer.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
import UIKit
import RxSwift

class WeatherViewContainer: UIView { // hasViewModel??
    
    private let successView = WeatherSuccessView()
    
    private let errorView = WeatherErrorView()
    
    private let loadingView = LoadingScreen()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        addSubview(errorView)
        addSubview(loadingView)
        addSubview(successView)
        
        successView.snp.makeConstraints { make in
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
}

extension WeatherViewContainer {
    
    enum WeatherState {
        case initial
        case loading
        case success(WeatherModelDomain)
        case error
    }
    
    func render(state: WeatherState) {
        switch state {
        case .initial:
            errorView.isHidden = true
            loadingView.isHidden = true
            successView.isHidden = false // check coreData and load data from it, or send searchSelected event
        case .loading:
            errorView.isHidden = true
            loadingView.isHidden = false
            successView.isHidden = true
        case let .success(data):
            errorView.isHidden = true
            loadingView.isHidden = true
            successView.isHidden = false
            successView.renderUI(data: data)
        case .error:
            errorView.isHidden = false
            loadingView.isHidden = true
            successView.isHidden = true
        }
    }
}

extension WeatherViewContainer {
    
    enum Event {
        case searchSelected
    }
    
    var event: Observable<Event> {
        Observable.merge(
            successView.event
                .asObservable()
                .map { event in
                    switch event {
                    case .search:
                        return .searchSelected
                    }
                },
            
            errorView.event
                .asObservable()
                .map({ event in
                    switch event {
                    case .retrySearch:
                        return .searchSelected
                    }
                })
        )
    }
}
