//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

struct MainViewModel {
    let categories: [String]
}

final class MainPresenter {
    weak var view: MainViewInputProtocol?
    
    private let interactor: MainInteractorInputProtocol
        
    init(interactor: MainInteractorInputProtocol) {
        self.interactor = interactor
    }
}

// MARK: - CategoriesInteractorOutputProtocol
extension MainPresenter: MainViewOutputProtocol {
    func favoriteButtonPressed() {}
    
    func didTapCell(with category: String) {
        
    }
    
    func viewDidLoad() {
        interactor.getCategories()
    }
}

// MARK: - CategoriesInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func categoriesDidReceive(_ categories: [String]) {
        let categoriesViewModel = MainViewModel(categories: categories)
        view?.setCategories(categoriesViewModel: categoriesViewModel)
    }
}

