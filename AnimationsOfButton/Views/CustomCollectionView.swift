//
//  CustomCollectionView.swift
//  AnimationsOfButton
//
//  Created by Marat Shagiakhmetov on 29.01.2024.
//

import UIKit

class CustomCollectionView: UICollectionView, UICollectionViewDelegate {
    private let cellLayout = UICollectionViewFlowLayout()
    private let images = Images.allCases.shuffled()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: cellLayout)
        setViews()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setViews() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        cellLayout.minimumLineSpacing = 4
        cellLayout.minimumInteritemSpacing = 4
        register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.cell)
    }
    
    private func setDelegate() {
        delegate = self
        dataSource = self
    }
}

extension CustomCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.cell,
            for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        let image = images[indexPath.item]
        cell.imageForCell(image: image.rawValue)
        
        return cell
    }
}

extension CustomCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 50, height: 50)
    }
}

//extension CustomCollectionView {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let image = images[indexPath.item]
//        let mainVC = MainViewController()
//        mainVC.setImage(image: image.rawValue)
//    }
//}
