//
//  MainViewController.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

import UIKit
import SnapKit

protocol MainViewInputProtocol: AnyObject {
    func setCategories(categoriesViewModel: MainViewModel)
}

protocol MainViewOutputProtocol {
    func viewDidLoad()
    func didTapCell(with category: String)
    func favoriteButtonPressed()
}

final class MainViewController: UIViewController {
    
    var presenter: MainViewOutputProtocol?
    
    private let tableView = UITableView.init(frame: .zero)
    private let configurator: MainConfiguratorInputProtocol = MainConfigurator()
    
    private var categories: [String] = []
    
//    private lazy var tableView: UITableView = {
//        let tableView = UITableView(frame: .zero)
//        tableView.
//        return tableView
//    }()
        
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background")
        imageView.contentMode = .scaleAspectFill
        return imageView
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - PrivateMethods
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
//        tableView.isScrollEnabled = true
        tableView.bounces = false
    }
    
    func addSubviews() {
        view.addSubview(imageView)
        view.addSubview(tableView)
        
        tableView.frame = view.bounds
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(-view.frame.height / 5)
            make.leading.equalTo(view).offset(-view.frame.height / 5)
            make.trailing.equalTo(view).offset(view.frame.height / 5)
            make.bottom.equalTo(view)
        }
    }
    
    private func setupNavigationBar() {
//        navigationController?.preferredContentSize =
    }
    
    @objc func favoriteButtonTapped() {
        presenter?.favoriteButtonPressed()
    }
}

// MARK: - TableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.didTapCell(with: categories[safe: indexPath.row] ?? "all")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
        UIView.animate(withDuration: 0.5, delay: 0.05 * Double(indexPath.row)) {
            cell.transform = CGAffineTransform(translationX: cell.contentView.frame.width, y: cell.contentView.frame.height)
        }
    }
}

// MARK: - TableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        1
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = "categories[safe: indexPath.row]"
        cell.layer.cornerRadius = 20
        
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView.frame.height * 0.4
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.frame.height - 20
    }
}

// MARK: - CategoriesViewInputProtocol
extension MainViewController: MainViewInputProtocol {
    func setCategories(categoriesViewModel: MainViewModel) {
        self.categories = categoriesViewModel.categories
        tableView.reloadData()
    }
}
