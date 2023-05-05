//
//  TemperatureView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 26.04.2023.
//

import Foundation
import UIKit

class TemperatureView: UIView {
    
    let cloudImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "cloud.drizzle.fill")
        return iv
    }()
    
    let temperature = CustomLabel(font: Resources.Font.Name.thin,
                                  size: Resources.Font.Size.title4,
                                  text: "10°C", color: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = min(bounds.height, bounds.width)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        UIColor.white.set()
        path.fill()
    }
    
    private func setupViews() {
        
        addSubViews(subViews: [
            cloudImage, temperature,
        ])
        
        
        cloudImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(Resources.Constraints.cloudImageSide)
            make.top.equalToSuperview()
        }
        
        temperature.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
