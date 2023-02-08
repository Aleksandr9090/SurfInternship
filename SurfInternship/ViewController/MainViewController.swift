//
//  MainViewController.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

import UIKit
import SnapKit

extension MainViewController {
    struct Appearance {
        let barButtonTitle = "Отправить заявку"
        let backgroundImage = UIImage(named: "background")
        let subTitleColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        let questionLabelText = "Хочешь к нам?"
        let alertTitle = "Поздравляем!"
        let alertDescription = "Ваша заявка успешно отправлена!"
    }
}

final class MainViewController: UIViewController {
    
    var presenter: MainViewOutputProtocol?
    
    private let tableView = UITableView.init(frame: .zero)
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    private let appearance = Appearance()
    private var specialties: [String] = []
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
        
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = appearance.backgroundImage
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var barButton: UIButton = {
        let button = UIButton()
        button.setTitle(appearance.barButtonTitle, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = appearance.subTitleColor
        label.font = .systemFont(ofSize: 14)
        label.text = appearance.questionLabelText
        return label
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(withView: self)
        presenter?.viewDidLoad()
        
        setupTableView()
        view.backgroundColor = .clear
        setupNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addSubviews()
        barButton.layer.cornerRadius = barButton.frame.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - PrivateMethods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    private func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(tableView)
        view.addSubview(barView)
        view.addSubview(barButton)
        view.addSubview(questionLabel)
        
        tableView.frame = view.bounds
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(-view.frame.height / 5)
            make.leading.equalTo(view).offset(-view.frame.height / 5)
            make.trailing.equalTo(view).offset(view.frame.height / 5)
            make.bottom.equalTo(view)
        }
        
        barView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-98)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.bottom.equalTo(view).offset(view.frame.height / 5)
        }
        
        barButton.snp.makeConstraints { make in
            make.top.equalTo(barView)
            make.trailing.equalTo(barView).offset(-20)
            make.height.equalTo(60)
            make.width.equalTo(219)
        }
        
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(barView)
            make.trailing.equalTo(barButton.snp.leading).offset(-24)
            make.height.equalTo(60)
        }
    }
    
    @objc private func buttonAction() {
        showAlert()
    }
    
    private func setupNavigationBar() { }
    
    private func showAlert() {
        let alert = UIAlertController(
            title: appearance.alertTitle,
            message: appearance.alertDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {}

// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell()}
        
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .white
        cell.contentView.layer.cornerRadius = 30
        cell.specialties = specialties
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.frame.height * 0.33
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height - 80
    }
}

// MARK: - CategoriesViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func setSpecialties(specialtiesViewModel: MainViewModel) {
        self.specialties = specialtiesViewModel.specialties
        tableView.reloadData()
    }
}
