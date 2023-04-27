//
//  FiveDaysView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import Foundation
import UIKit
import SnapKit

class FiveDaysView: UIView {
    
    var weekWeather = [Any]()
    
    let fiveDaysLabel = CustomLabel(font: Resources.Fonts.Name.bold,
                            size: Resources.Fonts.Size.regular3,
                            text: "The Next 5 days",
                            color: .black)
    
    
    let day = CustomLabel(font: Resources.Fonts.Name.regular,
                          size: Resources.Fonts.Size.regular1,
                          text: "",
                          color: .black)
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
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
        
        for _ in 0..<5 {
            let weekDayView = WeekDayView()
            
            weekDayView.snp.makeConstraints { make in
                make.height.equalTo(Resources.Constraints.weekDaySide)
            }
            
            stackView.addArrangedSubview(weekDayView)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(Resources.Constraints.weekDaySide)
            make.width.equalTo(Resources.Constraints.weekDaySide * 5)
        }
        
        fiveDaysLabel.snp.makeConstraints { make in
            make.bottom.equalTo(stackView.snp.top)
                .inset(-16)
            make.left.equalTo(stackView.snp.left)
        }
    }
    
}
