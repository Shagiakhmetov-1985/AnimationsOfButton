//
//  CollectionViewCell.swift
//  AnimationsOfButton
//
//  Created by Marat Shagiakhmetov on 29.01.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    var delegate: CustomCollectionViewDelegate!
    static let cell = "cell"
    
    private let picture = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func imageForCell(image: String) {
        let size = UIImage.SymbolConfiguration(pointSize: 24)
        picture.image = UIImage(systemName: image, withConfiguration: size)
        picture.tintColor = .white
    }
    
    private func setViews() {
        backgroundColor = .systemGray
        layer.cornerRadius = 6
        contentView.addSubview(picture)
        picture.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            picture.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            picture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension CollectionViewCell {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
}
