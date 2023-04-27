//
//  WeekDayView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation
import UIKit

class WeekDayView: UIView {
    
    let temperature = CustomLabel(font: Resources.Fonts.Name.regular,
                                  size: Resources.Fonts.Size.regular1,
                                  text: "8C",
                                  color: .black)
    
    let weatherImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "cloud.fill")
        return iv
    }()
    
    let squareView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.systemGray6.cgColor
        layer.borderWidth = 2
        layer.cornerRadius = Resources.Constraints.weekDayRadius
        backgroundColor = .red
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Resources.Constraints.weekDayRadius)
        
        UIColor.clear.set()
        path.fill()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubViews(subViews: [
            weatherImage, temperature
        ])
        
        weatherImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(13)
        }
        
        temperature.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(weatherImage.snp.bottom).offset(6)
        }
    }
}
