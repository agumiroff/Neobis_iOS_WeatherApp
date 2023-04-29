//
//  DetailViewController.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 25.04.2023.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class SearchScreenVCImplementation: UIViewController, SearchScreenVC {
   
    typealias ViewModelType = SearchScreenViewModel
    var viewModel: ViewModelType?
    
    private var cities = [LocationModel]()
    
    private let searchView = SearchView()
    
    private let disposeBag = DisposeBag()
    
    private let searchField: UITextField = {
        let field = UITextField()
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.leftView = padding
        field.leftViewMode = .always
        field.placeholder = "Search Location".uppercased()
        field.layer.cornerRadius = 20
        field.backgroundColor = .systemGray4
        return field
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeSerach), for: .touchUpInside)
        return button
    }()
    
    private let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(CollectionViewCell.self,
                            forCellWithReuseIdentifier: CollectionViewCell.cellId)
        return collection
    }()
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        navigationController?.isToolbarHidden = true
        
        setupViews()
        collectionConfig()
        bindText()
        bindCities()
        setupGradient()
        viewModel?.viewDidLoad()
    }
    
    private func setupViews() {
        view.addSubview(searchView)
        searchView.addSubview(closeButton)
        searchView.addSubview(searchField)
        searchView.addSubview(collection)
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(28)
            make.right.equalToSuperview()
                .inset(23)
        }
        
        searchField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
                .inset(55)
            make.top.equalTo(closeButton.snp.bottom)
                .inset(12)
            make.height.equalTo(44)
        }
        
        collection.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom)
                .offset(30)
            make.bottom.equalToSuperview()
        }
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.snp.centerY)
        }
    }
    
    private func collectionConfig() {
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 10, left: 10,
                                               bottom: 0, right: 10)
    }
    
    private func bindText() {
        searchField.rx.text
            .asObservable()
            .subscribe {[weak self]  _ in
                if self?.searchField.text == "" { return }
                self?.viewModel?.searchCall(call: self?.searchField.text ?? "")
            }
            .disposed(by: disposeBag)
    }
    
    private func bindCities() {
        viewModel?.cities
            .asObservable()
            .subscribe(onNext: { [weak self] cities in
                self?.cities = cities
                DispatchQueue.main.async {
                    self?.collection.reloadData()
                }
            })
            .disposed(by: disposeBag)
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
    
    func textFieldDidChange(text: String) {
        
    }
    
    @objc private func closeSerach() {
        viewModel?.pop()
    }
    
}




extension SearchScreenVCImplementation: UICollectionViewDelegate,
                        UICollectionViewDataSource,
                        UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Items in section. There should be [arrayWithData].count
        cities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //put your cell here
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId, for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell()}
        cell.configureCell(city: cities[indexPath.row].name, country: cities[indexPath.row].country)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width - 20, height: 40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.locationDidTap(location: cities[indexPath.row])
    }
}
