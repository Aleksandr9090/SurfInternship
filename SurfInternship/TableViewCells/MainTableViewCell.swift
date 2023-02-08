//
//  MainTableViewCell.swift
//  SurfInternship
//
//  Created by Aleksandr on 04.02.2023.
//

import UIKit

// MARK: - Appearance
extension MainTableViewCell {
    struct Appearance {
        let titleLabelTextColor = UIColor(red: 0.192, green: 0.192, blue: 0.192, alpha: 1)
        let titleLabelText = "Стажировка в Surf"
        let titleLabelFont = UIFont.boldSystemFont(ofSize: 24)
        
        let descriptionLabelTextColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        let descriptionLabelFont = UIFont.systemFont(ofSize: 14)
        let firstDescriptionLabelText = "Работай над реальными задачами под руководством опытного наставника и получи возможность стать частью команды мечты."
        let secondDescriptionLabelText = "Получай стипендию, выстраивай удобный график, работай на современном железе."
    }
}

final class MainTableViewCell: UITableViewCell {
    // MARK: - Property
    static let identifier = "mainCell"

    private var firstCollectionView: UICollectionView!
    private var secondCollectionView: UICollectionView!
    private let appearance = Appearance()
    
    private var secondCellsState: [Bool] = []
    
//    var completion: (() -> ())?
    
    var specialties: [String] = []
    
    // MARK: - Views
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.titleLabelTextColor
        label.font = appearance.titleLabelFont
        label.text = appearance.titleLabelText
        return label
    }()
    
    private lazy var firstDescriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = appearance.descriptionLabelTextColor
        view.font = appearance.descriptionLabelFont
        view.numberOfLines = 0
        view.text = appearance.firstDescriptionLabelText
        return view
    }()
    
    private lazy var secondDescriptionLabel: UILabel = {
        let view = UILabel()
        view.textColor = appearance.descriptionLabelTextColor
        view.font = appearance.descriptionLabelFont
        view.numberOfLines = 0
        view.text = appearance.secondDescriptionLabelText
        return view
    }()
    
    // MARK: - Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
}

// MARK: - Fileprivate methods
fileprivate extension MainTableViewCell {
    func setupUI() {
        firstCollectionViewConfiguration()
        secondCollectionViewConfiguration()
        addSubviews()
        makeConstraints()
    }
    
    func firstCollectionViewConfiguration() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        firstCollectionView = UICollectionView(
            frame: contentView.bounds,
            collectionViewLayout: layout
        )

        firstCollectionView.isScrollEnabled = true
        firstCollectionView.dataSource = self
        firstCollectionView.delegate = self
        firstCollectionView.backgroundColor = .clear
        firstCollectionView.bounces = false
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.register(FirstCollectionViewCell.self, forCellWithReuseIdentifier: FirstCollectionViewCell.identifier)
    }
    
    func secondCollectionViewConfiguration() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        secondCollectionView = UICollectionView(
            frame: contentView.bounds,
            collectionViewLayout: layout
        )
        secondCollectionView.isScrollEnabled = true
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.backgroundColor = .clear
        secondCollectionView.bounces = false
        secondCollectionView.showsHorizontalScrollIndicator = false
        secondCollectionView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: SecondCollectionViewCell.identifier)
    }

    func addSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(firstDescriptionLabel)
        contentView.addSubview(firstCollectionView)
        contentView.addSubview(secondDescriptionLabel)
        contentView.addSubview(secondCollectionView)
    }
    
    func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview()
            make.height.equalTo(32)
        }
        
        firstDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        firstCollectionView.snp.makeConstraints { make in
            make.top.equalTo(firstDescriptionLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        secondDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(firstCollectionView.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        secondCollectionView.snp.makeConstraints { make in
            make.top.equalTo(secondDescriptionLabel.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    
}

// MARK: - UICollectionViewCompositionalLayout
extension MainTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == firstCollectionView {
            return CGSize(width: specialties[indexPath.row].count * 10 + 48, height: 44)
        } else {
            return CGSize(width: specialties[indexPath.row].count * 10 + 48, height: 44)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == firstCollectionView {
            return UIEdgeInsets(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
            )
        } else {
            return UIEdgeInsets(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
            )
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MainTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        specialties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            guard
                let firstCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: FirstCollectionViewCell.identifier,
                    for: indexPath) as? FirstCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            firstCell.button.setTitle(specialties[indexPath.row], for: .normal)
            
            return firstCell
        } else {
            guard
                let secondCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: SecondCollectionViewCell.identifier,
                    for: indexPath) as? SecondCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            secondCell.label.text = specialties[indexPath.row]
            secondCell.cellTappedState = secondCellState
//            secondCell.button.setTitle(specialties[indexPath.row], for: .normal)
            return secondCell
        }
    }
}

// MARK: - UICollectionViewDelegate
extension MainTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == firstCollectionView {
            firstCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        } else {
            secondCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
//            secondCellState.toggle()
        }
    }
}
