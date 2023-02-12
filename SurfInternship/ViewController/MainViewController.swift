//
//  MainViewController.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

import UIKit
import SnapKit

// MARK: - Appearance
extension MainViewController {
    struct Appearance {
        static let barButtonTitle = "Отправить заявку"
        static let backgroundImage = UIImage(named: "background")
        static let subTitleColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        static let questionLabelText = "Хочешь к нам?"
        static let alertTitle = "Поздравляем!"
        static let alertDescription = "Ваша заявка успешно отправлена!"
    }
}

final class MainViewController: UIViewController {
    // MARK: - Property
    var presenter: MainViewOutputProtocol?
    
    private let tableView = UITableView.init(frame: .zero)
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    private var specialties: [Specialty] = []
    
    // MARK: - Views
    private lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Appearance.backgroundImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var barButton: UIButton = {
        let button = UIButton()
        button.setTitle(Appearance.barButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.setTitleColor(.purple, for: .highlighted)
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Appearance.subTitleColor
        label.font = .systemFont(ofSize: 14)
        label.text = Appearance.questionLabelText
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(withView: self)
        presenter?.viewDidLoad()
        
        setupTableView()
        addSubviews()
        makeConstraints()
        
        view.backgroundColor = .clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        barButton.layer.cornerRadius = barButton.frame.height / 2
    }
}

// MARK: - Filerivate Methods
private extension MainViewController {
    func setupTableView() {
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: MainTableViewCell.identifier
        )
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(imageView)
        view.addSubview(tableView)
        view.addSubview(barView)
        view.addSubview(barButton)
        view.addSubview(questionLabel)
    }
    
    func makeConstraints() {
        tableView.frame = view.frame
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(-view.frame.height / 5)
            make.leading.equalTo(view).offset(-view.frame.height / 5)
            make.trailing.equalTo(view).offset(view.frame.height / 5)
            make.bottom.equalTo(view)
        }
        
        if tableView.frame.height > 736 {
            barView.snp.makeConstraints { make in
                make.top.equalTo(view.snp.bottom).offset(-98)
                make.leading.equalTo(view)
                make.trailing.equalTo(view)
                make.bottom.equalTo(view).offset(view.frame.height / 5)
            }
        } else {
            barView.snp.makeConstraints { make in
                make.top.equalTo(view.snp.bottom).offset(-76)
                make.leading.equalTo(view)
                make.trailing.equalTo(view)
                make.bottom.equalTo(view).offset(view.frame.height / 5)
            }
        }
        
        barButton.snp.makeConstraints { make in
            make.top.equalTo(barView)
            make.trailing.equalTo(barView).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(219)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(barView)
            make.leading.equalToSuperview().offset(20)
            make.height.equalTo(60)
        }
    }
    
    @objc func buttonAction() {
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(
            title: Appearance.alertTitle,
            message: Appearance.alertDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.frame.height > 736 {
            return tableView.frame.height - 530 - (navigationController?.navigationBar.frame.height ?? 0)
        } else {
            return tableView.frame.height - 480 - (navigationController?.navigationBar.frame.height ?? 0)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height - (view.window?.safeAreaInsets.bottom ?? 0) / 2 - (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }
    
}

// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell
        else { return UITableViewCell()}
        
        let firstSpecialties = self.specialties.filter { $0.collectionViewIndex == 0 }
        let secondSpecialties = self.specialties.filter { $0.collectionViewIndex == 1 }
        
        cell.configure(firstSpecialties: firstSpecialties, secondSpecialties: secondSpecialties)
        
        return cell
    }
}

// MARK: - MainViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func setSpecialties(specialtiesViewModel: MainViewModel) {
        self.specialties = specialtiesViewModel.specialties
    }
}
