//
//  MainTableViewCell.swift
//  SurfInternship
//
//  Created by Aleksandr on 04.02.2023.
//

import UIKit

// MARK: - BubbleCollectionViewCellDelegate
protocol BubbleCollectionViewCellDelegate {
    func cellDidTap(indexPath: IndexPath, isSelected: Bool, collectionViewIndex: Int)
}

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
    
    private var firstSpecialties: [Specialty] = []
    private var secondSpecialties: [Specialty] = []

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
    
    // MARK: - Iternal
    func configure(firstSpecialties: [Specialty], secondSpecialties: [Specialty]) {
        self.firstSpecialties = firstSpecialties
        self.secondSpecialties = secondSpecialties
    }
}

// MARK: - Fileprivate methods
private extension MainTableViewCell {
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 30

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
        firstCollectionView.showsHorizontalScrollIndicator = false
        firstCollectionView.register(
            BubbleCollectionViewCell.self,
            forCellWithReuseIdentifier: BubbleCollectionViewCell.identifier
        )
    }
    
    func secondCollectionViewConfiguration() {
        let layout = LeftAlignedHorizontalCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        secondCollectionView = UICollectionView(
            frame: contentView.bounds,
            collectionViewLayout: layout
        )
        
        secondCollectionView.isScrollEnabled = true
        secondCollectionView.dataSource = self
        secondCollectionView.delegate = self
        secondCollectionView.backgroundColor = .clear
        secondCollectionView.showsHorizontalScrollIndicator = false
        secondCollectionView.register(
            BubbleCollectionViewCell.self,
            forCellWithReuseIdentifier: BubbleCollectionViewCell.identifier
        )
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
    
    func sizeOfString (string: String) -> CGSize {
        return NSString(string: string).boundingRect(
            with: CGSize(width: 0, height: 0),
            options: .usesFontLeading,
            attributes: [.font: UIFont.systemFont(ofSize: 14)],
            context: nil
        ).size
    }
}

// MARK: - UICollectionViewCompositionalLayout
extension MainTableViewCell: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == firstCollectionView {
            guard let text = firstSpecialties[safe: indexPath.row]?.title else { return CGSize()}
            return CGSize(width: sizeOfString(string: text).width + 48, height: 44)
        } else {
            guard let text = secondSpecialties[safe: indexPath.row]?.title else { return CGSize()}
            return CGSize(width: sizeOfString(string: text).width + 48, height: 44)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
                )
    }
}

// MARK: - UICollectionViewDataSource
extension MainTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == firstCollectionView {
            return firstSpecialties.count
        } else {
            return secondSpecialties.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == firstCollectionView {
            guard
                let firstCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BubbleCollectionViewCell.identifier,
                    for: indexPath) as? BubbleCollectionViewCell, let speciality = firstSpecialties[safe: indexPath.row]
            else {
                return UICollectionViewCell()
            }
        
            firstCell.configure(title: speciality.title, isSelected: speciality.isSelected, delegate: self, indexPath: indexPath, collectionViewIndex: 0)
            
            return firstCell
        } else {
            guard
                let secondCell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BubbleCollectionViewCell.identifier,
                    for: indexPath) as? BubbleCollectionViewCell, let speciality = firstSpecialties[safe: indexPath.row]
            else {
                return UICollectionViewCell()
            }
            
            secondCell.configure(title: speciality.title, isSelected: speciality.isSelected, delegate: self, indexPath: indexPath, collectionViewIndex: 1)

            return secondCell
        }
    }
}

// MARK: - BubbleCollectionViewCellDelegate
extension MainTableViewCell: BubbleCollectionViewCellDelegate {
    func cellDidTap(indexPath: IndexPath, isSelected: Bool, collectionViewIndex: Int) {
        firstSpecialties[indexPath.row].isSelected = isSelected
        if collectionViewIndex == 0 {
            firstCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        }
    }
}
