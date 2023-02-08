//
//  MainConfigurator.swift
//  SurfInternship
//
//  Created by Aleksandr on 03.02.2023.
//

final class MainConfigurator: MainConfiguratorInputProtocol {
    func configure(withView view: MainViewController) {
        let interactor = MainInteractor()
        let presenter = MainPresenter(interactor: interactor)
        
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
    }
}
