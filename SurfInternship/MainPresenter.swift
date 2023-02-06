//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

struct MainViewModel {
    let specialties: [String]
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
        interactor.getSpecialties()
    }
}

// MARK: - CategoriesInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func specialtiesDidReceive(_ specialties: [String]) {
        let specialtiesViewModel = MainViewModel(specialties: specialties)
        view?.setSpecialties(specialtiesViewModel: specialtiesViewModel)
    }
}

