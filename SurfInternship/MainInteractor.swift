//
//  MainInteractor.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

protocol  MainInteractorInputProtocol: AnyObject {
    func getCategories()
}

protocol MainInteractorOutputProtocol: AnyObject {
    func categoriesDidReceive(_ categories: [String])
}

final class MainInteractor: MainInteractorInputProtocol {
    weak var presenter: MainInteractorOutputProtocol?
    
    func getCategories() {
        
    }
}
