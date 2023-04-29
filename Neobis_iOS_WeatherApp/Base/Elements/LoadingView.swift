//
//  LoadingView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 29.04.2023.
//

import Foundation
import UIKit

class LoadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = min(bounds.height, bounds.width)
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        UIColor.red.set()
        path.fill()
    }
}
