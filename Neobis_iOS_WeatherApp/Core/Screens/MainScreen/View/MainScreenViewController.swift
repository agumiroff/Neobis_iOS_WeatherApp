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

class MainScreenViewController: UIViewController, ViewController {
    
    typealias ViewModelType = MainScreenViewModel
    
    var viewModel: ViewModelType?
    
    var state: State = .initial
    
    private let searchLogo: UIButton = {
        let iv = UIButton()
        iv.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        iv.tintColor = .black
        return iv
    }()
    
    private let temperatureView = TemperatureView()
    
    private let fiveDaysView = FiveDaysView()
    
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
                                       text: "Humidity", color: .white)
    
    private let humidityValue = CustomLabel(font: Resources.Fonts.Name.regular,
                                            size: Resources.Fonts.Size.title1,
                                            text: "85%", color: .white)
    
    private let airPressure = CustomLabel(font: Resources.Fonts.Name.regular,
                                          size: Resources.Fonts.Size.regular3,
                                          text: "Air pressure", color: .white)
    
    private let airPressureValue = CustomLabel(font: Resources.Fonts.Name.regular,
                                               size: Resources.Fonts.Size.title1,
                                               text: "998 mb", color: .white)
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.state1
            .asObservable()
            .subscribe(onNext: { state in
                print(state)
            })
        
        updateUI()
        setupGradient()
        navigationBarSetup()
        
    }
    
    private func setupViews() {
        
        view.addSubViews(subViews: [
            dateLabel, city, country, temperatureView, windStatus, windSpeed, visibility, visibilityRange, humidity, humidityValue, airPressure, airPressureValue, fiveDaysView
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
                .offset(Resources.Constraints.attTitleTop)
            make.left.equalToSuperview()
            make.right.equalTo(view.snp.centerX)
        }
        
        windSpeed.snp.makeConstraints { make in
            make.top.equalTo(windStatus.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(windStatus.snp.centerX)
        }
        
        visibility.snp.makeConstraints { make in
            make.top.equalTo(temperatureView.snp.bottom)
                .offset(Resources.Constraints.attTitleTop)
            make.right.equalToSuperview()
            make.left.equalTo(view.snp.centerX)
        }
        
        visibilityRange.snp.makeConstraints { make in
            make.top.equalTo(visibility.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(visibility.snp.centerX)
        }
        
        humidity.snp.makeConstraints { make in
            make.centerX.equalTo(windStatus.snp.centerX)
            make.top.equalTo(windSpeed.snp.bottom).offset(20)
        }
        
        humidityValue.snp.makeConstraints { make in
            make.top.equalTo(humidity.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(humidity.snp.centerX)
        }
        
        airPressure.snp.makeConstraints { make in
            make.centerX.equalTo(visibility.snp.centerX)
            make.top.equalTo(visibilityRange.snp.bottom).offset(20)
        }
        
        airPressureValue.snp.makeConstraints { make in
            make.top.equalTo(airPressure.snp.bottom)
                .offset(Resources.Constraints.attValueTop)
            make.centerX.equalTo(airPressure.snp.centerX)
        }
        
        fiveDaysView.snp.makeConstraints { make in
            make.top.equalTo(humidityValue.snp.bottom)
                .offset(30)
            make.bottom.left.right.equalToSuperview()
        }
    }
    
    private func navigationBarSetup() {
        navigationController?.navigationBar.addSubview(searchLogo)
        searchLogo.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(searchCity)))
        searchLogo.isUserInteractionEnabled = true
        
        searchLogo.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(Resources.Constraints.searchLogoRight)
            make.top.equalToSuperview()
            make.width.height.equalTo(Resources.Constraints.searchLogoSize)
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
        switch self.state {
        case .initial:
            setupViews()
        case .loading:
            let loader = UIProgressView()
            view.addSubview(loader)
            loader.snp.makeConstraints { make in
                make.centerX.centerY.equalToSuperview()
            }
            view.subviews.map { subView in
                subView.isHidden = true
            }
        case .success:
            break
        case .failure:
            break
        }
   
    }
    
    @objc func searchCity() {
        viewModel?.state1 = .just(.loading)
    }
}

