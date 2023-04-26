//
//  DetailViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, View {
    
    
    
    var viewModel: DetailViewModel?
    
    let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        viewModel?.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    func updateUI() {
        
    }
}
