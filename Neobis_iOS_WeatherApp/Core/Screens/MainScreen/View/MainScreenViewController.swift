//
//  ViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainScreenViewController: UIViewController, View {
    
    typealias ViewModelType = MainScreenViewModelProtocol
    var viewModel: ViewModelType?
    
    private let searchLogo: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "magnifyingglass")
        iv.tintColor = .black
        return iv
    }()
    
    private let temperatureView = TemperatureView()
    
    private let dateLabel = CustomLabel(font: Resources.Fonts.Name.regular,
                                        size: Resources.Fonts.Size.regular3,
                                        text: "Today, May 7th, 2021", color: .white)
    
    private let city = CustomLabel(font: Resources.Fonts.Name.bold,
                                   size: Resources.Fonts.Size.title3,
                                   text: "Barcelona", color: .white)
    
    private let country = CustomLabel(font: Resources.Fonts.Name.regular,
                                      size: Resources.Fonts.Size.title1,
                                      text: "Spain", color: .white)
    
    private let windStatus = CustomLabel(font: Resources.Fonts.Name.bold,
                                         size: Resources.Fonts.Size.regular3,
                                         text: "Wind status", color: .white)
    
    private let windSpeed = CustomLabel(font: Resources.Fonts.Name.regular,
                                        size: Resources.Fonts.Size.title1,
                                        text: "7 mph", color: .white)
    
    private let visibility = CustomLabel(font: Resources.Fonts.Name.regular,
                                         size: Resources.Fonts.Size.regular3,
                                         text: "Visibility", color: .white)
    
    private let visibilityRange = CustomLabel(font: Resources.Fonts.Name.regular,
                                              size: Resources.Fonts.Size.title1,
                                              text: "6.4 miles", color: .white)
    
    private let humidity = CustomLabel(font: Resources.Fonts.Name.regular,
                                       size: Resources.Fonts.Size.regular3,
                                       text: "Today, May 7th, 2021", color: .white)
    
    private let humidityValue = CustomLabel(font: Resources.Fonts.Name.regular,
                                            size: Resources.Fonts.Size.regular3,
                                            text: "Today, May 7th, 2021", color: .white)
    
    private let airPressure = CustomLabel(font: Resources.Fonts.Name.regular,
                                          size: Resources.Fonts.Size.regular3,
                                          text: "Today, May 7th, 2021", color: .white)
    
    private let airPressureValue = CustomLabel(font: Resources.Fonts.Name.regular,
                                               size: Resources.Fonts.Size.regular3,
                                               text: "Today, May 7th, 2021", color: .white)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        navigationBarSetup()
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubViews(subViews: [
            dateLabel, city, country, temperatureView, windStatus, windSpeed, visibility, visibilityRange, humidity, humidityValue, airPressure, airPressureValue,
        ])
        
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                .offset(10)
        }
        
        city.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom)
        }
        
        country.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(city.snp.bottom)
        }
        
        temperatureView.layer.cornerRadius = self.temperatureView.bounds.width / 2
        temperatureView.snp.makeConstraints { make in
            make.top.equalTo(country.snp.bottom)
                .offset(Resources.Constraints.temperatureViewTop)
            make.left.right.equalToSuperview()
                .inset(Resources.Constraints.temperatureViewLeft)
            make.height.equalTo(temperatureView.snp.width)
        }
        
        windStatus.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom)
                .offset(Resources.Constraints.windStatusTop)
            make.left.equalToSuperview()
                .inset(Resources.Constraints.windStatusLeft)
        }
        
        windSpeed.snp.makeConstraints { make in
            make.top.equalTo(windStatus.snp.bottom)
                .offset(Resources.Constraints.windSpeedTop)
            make.centerX.equalTo(windStatus.snp.centerX)
        }
        
        visibility.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom)
                .offset(Resources.Constraints.windStatusTop)
            make.right.equalToSuperview()
                .inset(Resources.Constraints.windStatusLeft)
        }
        
        visibilityRange.snp.makeConstraints { make in
            make.top.equalTo(visibility.snp.bottom)
                .offset(Resources.Constraints.windSpeedTop)
            make.centerX.equalTo(visibility.snp.centerX)
        }
    }
    
    private func navigationBarSetup() {
        navigationController?.navigationBar.addSubview(searchLogo)
        searchLogo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchCity)))
        searchLogo.isUserInteractionEnabled = true
        
        searchLogo.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(25)
            make.top.equalToSuperview()
            make.width.height.equalTo(30)
        }
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
    
    func updateUI() {
        
    }
    
    @objc func searchCity() {
        print("search")
    }
}

