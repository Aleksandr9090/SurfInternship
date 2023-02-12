//
//  MainPresenter.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

struct MainViewModel {
    let specialties: [Specialty]
}

final class MainPresenter {
    weak var view: MainViewInputProtocol?
    
    private let interactor: MainInteractorInputProtocol
        
    init(interactor: MainInteractorInputProtocol) {
        self.interactor = interactor
    }
}

// MARK: - MainViewOutputProtocol
extension MainPresenter: MainViewOutputProtocol {
    func viewDidLoad() {
        interactor.getSpecialties()
    }
}

// MARK: - MainInteractorOutputProtocol
extension MainPresenter: MainInteractorOutputProtocol {
    func specialtiesDidReceive(_ specialties: [Specialty]) {
        let specialtiesViewModel = MainViewModel(specialties: specialties)
        view?.setSpecialties(specialtiesViewModel: specialtiesViewModel)
    }
}
