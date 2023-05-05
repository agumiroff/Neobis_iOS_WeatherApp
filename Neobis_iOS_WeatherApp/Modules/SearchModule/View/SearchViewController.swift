//
//  DetailViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    typealias ViewModelType = SearchScreenViewModel
    var viewModel: ViewModelType?
     
    private let container = SearchViewContainer()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindState()
        setupGradient()
    }
    
    private func setupUI() {
        
        view.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func bindState() {
        
        viewModel?.state
            .asObservable()
            .subscribe(onNext: { [weak self] state in
                guard let self = self else { return }
                self.render(state: state)
            })
            .disposed(by: disposeBag)
        
        container.event
            .asObservable()
            .subscribe(onNext: { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .none:
                    break
                case let .showWeather(state: state):
                    self.viewModel?.handleEvent(event: .showWeather(state: state))
                case let .showCities(value: value):
                    self.viewModel?.handleEvent(event: .showCities(value: value))
                case .pop:
                    self.viewModel?.handleEvent(event: .pop)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor(hexString: "#30A2C5").cgColor,
            UIColor(hexString: "#000000").cgColor,
        ]
        view.layer.insertSublayer(gradient, at: 0)
    }
    
}

extension SearchViewController {
    
    func render(state: State) {
        switch state.status {
        case .initial:
            container.render(state: state)
        case .loaded:
            container.render(state: .init(context: state.context))
        case .loading:
            container.render(state: state)
        case .failure:
            container.render(state: state)
        }
    }
    
    struct State {
        var context: Context
        var status: Status = .initial
    }
    
    struct Context {
        var location = LocationModel(name: "", lat: 0, lon: 0, country: "")
        var cities = [LocationModel]()
        var weather: WeatherModel = WeatherModel(list: [])
    }
    
    enum Status {
        case initial
        case loaded
        case loading
        case failure
    }
    
    enum Event {
        case none
        case showWeather(state: State)
        case showCities(value: String)
        case pop
    }
}
