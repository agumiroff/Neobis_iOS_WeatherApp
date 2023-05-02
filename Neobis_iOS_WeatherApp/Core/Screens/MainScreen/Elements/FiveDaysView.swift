//
//  FiveDaysView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FiveDaysView: UIView {
    
    private lazy var weatherList = BehaviorRelay<[WeatherList]>(value: [])
    
    private let fiveDaysLabel = CustomLabel(font: Resources.Fonts.Name.bold,
                            size: Resources.Fonts.Size.regular3,
                            text: "The Next 5 days",
                            color: .black)
    
    
    private let day = CustomLabel(font: Resources.Fonts.Name.regular,
                          size: Resources.Fonts.Size.regular1,
                          text: "",
                          color: .black)
    
    private var currentDate = NSDate.now
    
    private let disposeBag = DisposeBag()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        stack.alignment = .fill
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        bindWeatherList()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: UIRectCorner(arrayLiteral: .topRight, .topLeft), cornerRadii: CGSize(width: Resources.Constraints.fiveDaysRadius,height: Resources.Constraints.fiveDaysRadius))
        
        UIColor.white.set()
        path.fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(stackView)
        addSubview(fiveDaysLabel)
        
        
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
                .inset(15)
        }
        
        fiveDaysLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top)
                .inset(-26)
            make.left.equalTo(stackView.snp.left)
        }
    }
    
    private func updateUI(with weatherList: [WeatherList]) {
        for day in weatherList {
            
            let calendar = Calendar.current
            
            let date = calendar.dateComponents([.day], from: Date(timeIntervalSince1970: day.dt))
            let dateDay = date.day
            
            let nextDayDate = Calendar.current.date(byAdding: .day, value: 1, to: self.currentDate)!
            let nextDay = calendar.dateComponents([.day], from: nextDayDate).day
            
            if dateDay == nextDay {
                let weekDayView = WeekDayView()
                weekDayView.temperature.text = "\(Int(day.main["temp"] ?? 0.0))°C"
                weekDayView.weatherImage.loadImage(from: "https://openweathermap.org/img/wn/\(day.weather.first?.icon ?? "10d").png")
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE"
                
                weekDayView.day.text = "\(dateFormatter.string(from: Date(timeIntervalSince1970: day.dt)))"
                
                weekDayView.snp.makeConstraints { make in
                    make.height.equalTo(weekDayView.snp.width)
                }
                
                stackView.addArrangedSubview(weekDayView)
                
                currentDate = nextDayDate
            }
        }
    }
    
    private func bindWeatherList() {
        weatherList
            .asObservable()
            .subscribe { [weak self] list in
                self?.updateUI(with: list)
            }
            .disposed(by: disposeBag)
    }
    
    func configureView(data: [WeatherList]) {
        self.weatherList.accept(data)
    }
    
}
