//
//  SecondCollectionViewCell.swift
//  SurfInternship
//
//  Created by Aleksandr on 06.02.2023.
//

import UIKit
import SnapKit

// MARK: - Appearance
extension SecondCollectionViewCell {
    struct Appearance {
        let buttonBackgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        let buttonTappedBackgroundColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        let buttonTitleColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        let buttonTappedTitleColor: UIColor = .white
    }
}

final class SecondCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    static let identifier = "secondCollectionViewCell"
    
    var cellTappedState: Bool = false {
        didSet {
            if oldValue == false {
                self.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
                label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
            } else {
                self.backgroundColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
                label.textColor = .white
            }
        }
    }
    
    // MARK: - Views
//    lazy var button: UIButton = {
//        let button = UIButton(type: .system)
//        button.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
////        button.setTitle(specialty, for: .normal)
//        button.setTitleColor(.gray, for: .highlighted)
//        button.titleLabel?.font = .systemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        button.setTitleColor(UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1), for: .normal)
//        button.layer.cornerRadius = 12
//
//        return button
//    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
//        button.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
//        button.setTitle(specialty, for: .normal)
//        button.setTitleColor(.gray, for: .highlighted)
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
//        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//        button.setTitleColor(UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1), for: .normal)
//        button.layer.cornerRadius = 12

        return label
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override methods
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    // MARK: - public methods
//    func cellConfiguration() {}
//
//    @objc func buttonAction() {
//        buttonState.toggle()
//        changeButton(state: buttonState)
//    }

}

// MARK: - fileprivate SecondCollectionViewCell
fileprivate extension SecondCollectionViewCell {
    func configure() {
        addSubview()
        layout()
        cellConfigure()
    }
    
    func addSubview() {
//        contentView.addSubview(button)
        contentView.addSubview(label)
    }
    
    func cellConfigure() {
        self.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        self.layer.cornerRadius = 12
    }
    
    func layout() {
//        button.snp.makeConstraints { make in
//            make.top.equalTo(contentView)
//            make.leading.equalTo(contentView).offset(6)
//            make.trailing.equalTo(contentView).inset(6)
//            make.bottom.equalTo(contentView)
//        }
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(contentView)

        }
    }
    
//    func changeButton(state: Bool) {
//        if state == true {
//            button.backgroundColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
//            button.setTitleColor(.white, for: .normal)
//        } else  {
//            button.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
//            button.setTitleColor(UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1), for: .normal)
//        }
//    }
}

