//
//  MainViewController.swift
//  AnimationsOfButton
//
//  Created by Marat Shagiakhmetov on 24.01.2024.
//

import UIKit

protocol CustomCollectionViewDelegate {
    func didTapCell(image: String, title: String)
}

class MainViewController: UIViewController {
    private lazy var titleApp: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Palatino", size: 28)
        label.textAlignment = .center
        label.text = "Animations of button"
        label.textColor = #colorLiteral(red: 0.0486389026, green: 0.06296398491, blue: 0.8456050754, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonAnimation: UIButton = {
        let size = UIImage.SymbolConfiguration(pointSize: 33)
        let image = UIImage(systemName: "arrowshape.right", withConfiguration: size)
        let button = UIButton(type: .system)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.0486389026, green: 0.06296398491, blue: 0.8456050754, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 37.5
        button.layer.shadowRadius = 5
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 0, height: 6)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moveButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var picture: UIImageView = {
        let size = UIImage.SymbolConfiguration(pointSize: 55)
        let image = UIImage(systemName: "questionmark", withConfiguration: size)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Palatino", size: 24)
        label.textColor = .black
        label.text = "Free name"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var buttonSpringX: NSLayoutConstraint!
    private var buttonSpringY: NSLayoutConstraint!
    
    private var corner = Corner.rightUp
    private let images = Images.allCases.shuffled()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupDesign() {
        view.backgroundColor = #colorLiteral(red: 0.743561089, green: 0.764533937, blue: 1, alpha: 1)
    }
    
    private func setupSubviews() {
        setupSubviews(subviews: titleApp, buttonAnimation, collectionView, 
                      picture, titleName, on: view)
    }
    
    private func setupSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    @objc private func moveButton() {
        switch corner {
        case .rightUp:
            corner = .rightDown
            right()
        case .rightDown:
            corner = .leftDown
            down()
        case .leftDown:
            corner = .leftUp
            left()
        default:
            corner = .rightUp
            up()
        }
    }
    
    private func right() {
        let size = UIImage.SymbolConfiguration(pointSize: 33)
        let image = UIImage(systemName: "arrowshape.down", withConfiguration: size)
        moveAnimation(
            time: CGFloat.random(in: 0.6...0.8),
            constraint: buttonSpringX,
            constant: view.bounds.width - 115,
            color: UIColor(
                red: CGFloat.random(in: 0...255)/255,
                green: CGFloat.random(in: 0...255)/255,
                blue: CGFloat.random(in: 0...255)/255,
                alpha: 1),
            corner: CGFloat.random(in: 0...37.5),
            image: image)
    }
    
    private func down() {
        let size = UIImage.SymbolConfiguration(pointSize: 33)
        let image = UIImage(systemName: "arrowshape.left", withConfiguration: size)
        moveAnimation(
            time: CGFloat.random(in: 0.6...0.8),
            constraint: buttonSpringY,
            constant: view.bounds.height / 1.3,
            color: UIColor(
                red: CGFloat.random(in: 0...255)/255,
                green: CGFloat.random(in: 0...255)/255,
                blue: CGFloat.random(in: 0...255)/255,
                alpha: 1),
            corner: CGFloat.random(in: 0...37.5),
            image: image)
    }
    
    private func left() {
        let size = UIImage.SymbolConfiguration(pointSize: 33)
        let image = UIImage(systemName: "arrowshape.up", withConfiguration: size)
        moveAnimation(
            time: CGFloat.random(in: 0.6...0.8),
            constraint: buttonSpringX,
            constant: -view.bounds.width + 115,
            color: UIColor(
                red: CGFloat.random(in: 0...255)/255,
                green: CGFloat.random(in: 0...255)/255,
                blue: CGFloat.random(in: 0...255)/255,
                alpha: 1),
            corner: CGFloat.random(in: 0...37.5),
            image: image)
    }
    
    private func up() {
        let size = UIImage.SymbolConfiguration(pointSize: 33)
        let image = UIImage(systemName: "arrowshape.right", withConfiguration: size)
        moveAnimation(
            time: CGFloat.random(in: 0.6...0.8),
            constraint: buttonSpringY,
            constant: -view.bounds.height / 1.3,
            color: UIColor(
                red: CGFloat.random(in: 0...255)/255,
                green: CGFloat.random(in: 0...255)/255,
                blue: CGFloat.random(in: 0...255)/255,
                alpha: 1),
            corner: CGFloat.random(in: 0...37.5),
            image: image)
    }
    
    private func moveAnimation(time: CGFloat, constraint: NSLayoutConstraint, 
                               constant: CGFloat, color: UIColor, corner: CGFloat,
                               image: UIImage?) {
        UIView.animate(withDuration: time) { [self] in
            constraint.constant += constant
            buttonAnimation.backgroundColor = color
            buttonAnimation.layer.cornerRadius = corner
            buttonAnimation.setImage(image, for: .normal)
            view.layoutIfNeeded()
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let image = images[indexPath.item]
        cell.imageForCell(image: image.rawValue)
        cell.delegate = self
        return cell
    }
}

extension MainViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleApp.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let constantX = -view.bounds.width / 2 + 57.5
        let constantY = -view.bounds.height / 2 + 125
        buttonSpringX = NSLayoutConstraint(
            item: buttonAnimation, attribute: .centerX, relatedBy: .equal, toItem: view,
            attribute: .centerX, multiplier: 1, constant: constantX)
        buttonSpringY = NSLayoutConstraint(
            item: buttonAnimation, attribute: .centerY, relatedBy: .equal, toItem: view,
            attribute: .centerY, multiplier: 1, constant: constantY)
        
        view.addConstraints([buttonSpringX, buttonSpringY])
        NSLayoutConstraint.activate([
            buttonAnimation.widthAnchor.constraint(equalToConstant: 75),
            buttonAnimation.heightAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.topAnchor.constraint(equalTo: titleApp.bottomAnchor, constant: 30),
            collectionView.widthAnchor.constraint(equalToConstant: 325),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            picture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            picture.bottomAnchor.constraint(equalTo: titleApp.topAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            titleName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleName.bottomAnchor.constraint(equalTo: picture.topAnchor, constant: -30)
        ])
    }
}

extension MainViewController: CustomCollectionViewDelegate {
    func didTapCell(image: String, title: String) {
        titleName.text = title
        let size = UIImage.SymbolConfiguration(pointSize: 55)
        picture.image = UIImage(systemName: image, withConfiguration: size)
    }
}
