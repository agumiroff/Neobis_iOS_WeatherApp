//
//  MainViewContainer.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 02.05.2023.
//

import Foundation
import UIKit
import RxSwift

class MainViewContainer: UIViewController, ViewController {
    
    typealias ViewModelType = MainScreenViewModel
    var viewModel: ViewModelType?
    
    private let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        bindViewModel()
        viewModel?.viewDidLoad()
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
    
    private func stateDidChange(state: State) {
        switch state {
        case .initial:
            removePreviousChildAndAdd(viewController: MainScreenViewController(viewModel: viewModel!))
        case .success:
            removePreviousChildAndAdd(viewController: MainScreenViewController(viewModel: viewModel!))
        case .loading:
            removePreviousChildAndAdd(viewController: LoadingScreen())
        case .failure:
            removePreviousChildAndAdd(viewController: ErrorScreen())
        }
    }
    
    private func bindViewModel() {
        viewModel?.state
            .asObservable()
            .subscribe(onNext: { [weak self] state in
                DispatchQueue.main.async {
                    self?.stateDidChange(state: state)
                }
            })
            .disposed(by: disposeBag)
    }
}
