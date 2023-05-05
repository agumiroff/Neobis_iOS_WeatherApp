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
    
    private lazy var weatherList = BehaviorRelay<[WeekDayModelDomain]>(value: [])
    
    private let fiveDaysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: Resources.Font.Name.bold,
            size: Resources.Font.Size.regular3
        )
        label.textAlignment = .center
        label.textColor = .black
        label.text = "The Next 5 days"
        return label
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(
            name: Resources.Font.Name.regular,
            size: Resources.Font.Size.regular1
        )
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
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
    
    private func updateUI(with weatherList: [WeekDayModelDomain]) {
        let weekDayView = WeekDayView()
        
        
    }
    
    private func bindWeatherList() {
        weatherList
            .asObservable()
            .subscribe { [weak self] list in
                self?.updateUI(with: list)
            }
            .disposed(by: disposeBag)
    }
    
    func configureView(data: [WeekDayModelDomain]) {
        self.weatherList.accept(data)
    }
    
}
