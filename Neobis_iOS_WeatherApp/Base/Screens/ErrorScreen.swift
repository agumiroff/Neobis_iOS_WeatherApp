//
//  ErrorScreen.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import UIKit

class ErrorScreen: UIViewController {
    
    let errorMessage: UILabel = {
        let label = UILabel()
        label.text = "Error message here"
        label.font = UIFont(name: Resources.Fonts.Name.regular, size: Resources.Fonts.Size.title3)
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGradient()
        setupUI()
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
    
    private func setupUI() {
        view.addSubview(errorMessage)
        
        errorMessage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
