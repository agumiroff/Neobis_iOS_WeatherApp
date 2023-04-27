//
//  SearchView.swift
//  Neobis_iOS_WeatherApp
//
//  Created by G G on 27.04.2023.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    let searchField: UITextField = {
        let field = UITextField()
        field.layer.cornerRadius = 50
        field.backgroundColor = .systemGray4
        return field
    }()
    
    let closeLabel: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "cross")
        return iv
    }()
    
    let collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero,
                                          collectionViewLayout: layout)
        collection.backgroundColor = UIColor.clear
        collection.register(CollectionViewCell.self,
                            forCellWithReuseIdentifier: CollectionViewCell.cellId)
        return collection
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let rect = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: Resources.Constraints.searchViewRadius)
        
        UIColor.white.set()
        path.fill()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupViews()
        collectionConfig()
    }
    
    func setupViews() {
        
        addSubview(closeLabel)
        addSubview(searchField)
        addSubview(collection)
        
        closeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(28)
            make.right.equalToSuperview()
                .inset(23)
        }
        
        searchField.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
                .inset(55)
            make.top.equalTo(closeLabel.snp.bottom)
                .inset(12)
        }
        
        collection.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(searchField.snp.bottom)
                .inset(30)
        }
    }
    
    func collectionConfig() {
        collection.delegate = self
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 10, left: 10,
                                               bottom: 0, right: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class CollectionViewCell: UICollectionViewListCell{
    static let cellId = "MainCollectionViewCell"
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
    
}


extension SearchView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //Items in section. There should be [arrayWithData].count
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //put your cell here
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellId, for: indexPath) as? CollectionViewCell
        else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //size for collectionViewCell
        CGSize(width: 200, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //space between cells
        50
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //logic for selection on item
        print("someLogic")
    }
}
