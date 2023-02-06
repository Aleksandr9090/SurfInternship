//
//  MainViewController.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

import UIKit
import SnapKit

protocol MainViewInputProtocol: AnyObject {
    func setSpecialties(specialtiesViewModel: MainViewModel)
}

protocol MainViewOutputProtocol {
    func viewDidLoad()
    func didTapCell(with category: String)
}

final class MainViewController: UIViewController {
    
    var presenter: MainViewOutputProtocol?
    
    private let tableView = UITableView.init(frame: .zero)
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
//    private var collectionViewModel: CollectionViewModelProtocol = CollectionViewModel()

    private var specialties: [String] = []
    
    private lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
        
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var barButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отправить заявку", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        return button
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.588, green: 0.584, blue: 0.608, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.text = "Хочешь к нам?"
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
//        tableView.isScrollEnabled = true
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
    }
    
    func addSubviews() {
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
            make.trailing.equalTo(barButton.snp.leading).offset(-20)
            make.height.equalTo(60)
        }
    }
    
    private func setupNavigationBar() {
//        navigationController?.preferredContentSize =
    }
    
}

// MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        presenter?.didTapCell(with: categories[safe: indexPath.row] ?? "all")
//    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
//        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
//            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
//        }
//    }
}

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
