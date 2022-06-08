//
//  AssemblyBuilder.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 07.06.2022.
//

import UIKit

protocol AssemblyBuilderProtocol {
    func createSearchMovieModule(router: RouterProtocol) -> UIViewController
    func createDetailMovieModule(result: Results, router: RouterProtocol) -> UIViewController
}

class AssemblyBuilder: AssemblyBuilderProtocol {
    func createSearchMovieModule(router: RouterProtocol) -> UIViewController {
        let view = SearchMovieViewController()
        let networkService = NetworkService()
        let presenter = SearchMoviePresenter(view: view, networkService: networkService, router: router)
        
        view.presenter = presenter
        return view
    }
    
    func createDetailMovieModule(result: Results, router: RouterProtocol) -> UIViewController {
        let view = DetailMovieViewController()
        let networkService = NetworkService()
        let presenter = DetailMoviePresenter(view: view, networkService: networkService, resultSearch: result, router: router)
        
        view.presenter = presenter
        return view
    }
}
