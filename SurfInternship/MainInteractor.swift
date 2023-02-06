//
//  MainInteractor.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

protocol  MainInteractorInputProtocol: AnyObject {
    func getSpecialties()
}

protocol MainInteractorOutputProtocol: AnyObject {
    func specialtiesDidReceive(_ specialties: [String])
}

final class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    
    func getSpecialties() {
        self.presenter?.specialtiesDidReceive(DataManager.shared.specialties)
    }
}
