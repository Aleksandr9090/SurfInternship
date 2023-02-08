//
//  MainInteractor.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

final class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    
    func getSpecialties() {
        self.presenter?.specialtiesDidReceive(DataManager.shared.specialties)
    }
}
