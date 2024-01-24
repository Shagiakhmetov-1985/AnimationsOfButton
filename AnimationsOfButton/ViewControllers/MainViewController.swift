//
//  MainViewController.swift
//  AnimationsOfButton
//
//  Created by Marat Shagiakhmetov on 24.01.2024.
//

import UIKit

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
        let size = UIImage.SymbolConfiguration(pointSize: 22)
        let image = UIImage(systemName: "arrowshape.right", withConfiguration: size)
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.titleLabel?.font = UIFont(name: "Palatino", size: 22)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.0486389026, green: 0.06296398491, blue: 0.8456050754, alpha: 1)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(moveButton), for: .touchUpInside)
        return button
    }()
    
    private var buttonSpring: NSLayoutConstraint!
    private var corner = Corner.rightUp
    
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
        setupSubviews(subviews: titleApp, buttonAnimation, on: view)
    }
    
    private func setupSubviews(subviews: UIView..., on otherSubview: UIView) {
        subviews.forEach { subview in
            otherSubview.addSubview(subview)
        }
    }
    
    @objc private func moveButton() {
        switch corner {
        case .rightUp:
            corner = .leftUp
            right()
        default:
            corner = .rightUp
            left()
        }
    }
    
    private func right() {
        UIView.animate(withDuration: 1) { [self] in
            buttonSpring.constant += view.bounds.width / 2 + 33.5
            buttonAnimation.backgroundColor = .systemPink
            view.layoutIfNeeded()
        }
    }
    
    private func left() {
        UIView.animate(withDuration: 1) { [self] in
            buttonSpring.constant -= view.bounds.width / 2 + 33.5
            buttonAnimation.backgroundColor = #colorLiteral(red: 0.0486389026, green: 0.06296398491, blue: 0.8456050754, alpha: 1)
            view.layoutIfNeeded()
        }
    }
}

extension MainViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleApp.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleApp.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        let constant = -view.bounds.width / 2 + 83
        buttonSpring = NSLayoutConstraint(
            item: buttonAnimation, attribute: .centerX, relatedBy: .equal, toItem: view,
            attribute: .centerX, multiplier: 1, constant: constant)
        view.addConstraint(buttonSpring)
        NSLayoutConstraint.activate([
            buttonAnimation.widthAnchor.constraint(equalToConstant: 150),
            buttonAnimation.heightAnchor.constraint(equalToConstant: 40),
            buttonAnimation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
}
