//
//  FirstCollectionViewCell.swift
//  SurfInternship
//
//  Created by Aleksandr on 05.02.2023.
//

import UIKit
import SnapKit

// MARK: - Appearance
extension BubbleCollectionViewCell {
    struct Appearance {
        static let buttonBackgroundColor = UIColor(red: 0.953, green: 0.953, blue: 0.961, alpha: 1)
        static let buttonTappedBackgroundColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        static let buttonTitleColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        static let buttonTappedTitleColor: UIColor = .white
    }
}

final class BubbleCollectionViewCell: UICollectionViewCell {
    // MARK: - Property
    static let identifier = "firstCollectionViewCell"
    
    var delegate: BubbleCollectionViewCellDelegate?
    var indexPath: IndexPath?
    var collectionViewIndex: Int?
            
    private var buttonIsSelected: Bool = false {
        didSet {
            changeButton(newValue: self.buttonIsSelected)
        }
    }
    
    // MARK: - Views
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = Appearance.buttonBackgroundColor
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(Appearance.buttonTitleColor, for: .normal)
        button.layer.cornerRadius = 12
        button.setTitleColor(.red, for: .highlighted)
        button.setTitleColor(Appearance.buttonTappedTitleColor, for: .selected)
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Iternal methods
    func configure(title: String, isSelected: Bool, delegate: MainTableViewCell, indexPath: IndexPath, collectionViewIndex: Int) {
        self.button.setTitle(title, for: .normal)
        self.buttonIsSelected = isSelected
        self.delegate = delegate
        self.indexPath = indexPath
        self.collectionViewIndex = collectionViewIndex
    }
}

// MARK: - Private methods
private extension BubbleCollectionViewCell {
    func setupUI() {
        addSubview()
        makeConstraints()
    }
    
    func addSubview() {
        contentView.addSubview(button)
    }
    
    func makeConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.leading.equalTo(contentView).offset(6)
            make.trailing.equalTo(contentView).inset(6)
            make.bottom.equalTo(contentView)
        }
    }
    
    func changeButton(newValue: Bool) {
        self.button.isSelected = newValue
        if button.isSelected {
            button.backgroundColor = Appearance.buttonTappedBackgroundColor
        } else  {
            button.backgroundColor = Appearance.buttonBackgroundColor
        }
    }
    
    @objc func buttonAction() {
        guard let indexPath, let collectionViewIndex = collectionViewIndex else { return }
        self.buttonIsSelected.toggle()
        delegate?.cellDidTap(indexPath: indexPath, isSelected: self.button.isSelected, collectionViewIndex: collectionViewIndex )
    }
}
