//
//  Router.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 07.06.2022.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyBuilderProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func navigateToDetailMovieViewController(result: Results)
}

class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyBuilderProtocol?
    
    init(navigationController: UINavigationController, assemblyBuilder: AssemblyBuilderProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationController = navigationController {
            guard let searchMovieViewController = assemblyBuilder?.createSearchMovieModule(router: self) else { return }
            navigationController.viewControllers = [searchMovieViewController]
        }
    }
    
    func navigateToDetailMovieViewController(result: Results) {
        if let navigationController = navigationController {
            guard let detailMovieViewController = assemblyBuilder?.createDetailMovieModule(result: result, router: self) else { return }
            navigationController.pushViewController(detailMovieViewController, animated: true)
        }
    }
}
