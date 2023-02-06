//
//  UpCollectionViewCell.swift
//  SurfInternship
//
//  Created by Aleksandr on 05.02.2023.
//

import UIKit
import SnapKit

class FirstCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    static let identifier = "upCollectionViewCell"
    
//    var specialty: String?
    
    private var buttonState: Bool = false
    
    // MARK: - Views
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
//        button.setTitle(specialty, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1), for: .normal)
        button.layer.cornerRadius = 12

        return button
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
    
    func cellConfiguration() {}
    
    @objc private func buttonAction() {
        buttonState.toggle()
        changeButton(state: buttonState)
    }
                         
}

// MARK: - fileprivate FirstCollectionViewCell
fileprivate extension FirstCollectionViewCell {
    func configure() {
        addSubview()
        layout()
        addCornerRadius()
    }
    
    func addSubview() {
        contentView.addSubview(button)
    }
    
    func addCornerRadius() {

    }
    
    func layout() {
        button.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(6)
            make.trailing.equalTo(contentView).inset(6)
            make.bottom.equalTo(contentView)
        }
    }
    
    func changeButton(state: Bool) {
        if state == true {
            button.backgroundColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
            button.setTitleColor(.white, for: .normal)
        } else  {
            button.backgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
            button.setTitleColor(UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1), for: .normal)
        }
    }
}
