//
//  SearchMoviePresenter.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 07.06.2022.
//

import Foundation

protocol SearchMovieViewProtocol: AnyObject {
    func successData()
}

protocol SearchMovieViewPresenterProtocol: AnyObject {
    init(view: SearchMovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    var resultSearch: [Results]? { get set }
    func getResultSearch(searchText: String)
    func tapOnTheMovie(result: Results)
}

class SearchMoviePresenter: SearchMovieViewPresenterProtocol {
    weak var view: SearchMovieViewProtocol!
    let networkService: NetworkServiceProtocol!
    let router: RouterProtocol!
    
    var resultSearch: [Results]?
    
    required init(view: SearchMovieViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
    }
    
    func getResultSearch(searchText: String) {
        networkService.getResults(searchText: searchText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let results):
                    self?.resultSearch = results?.results
                    self?.view.successData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func tapOnTheMovie(result: Results) {
        router.navigateToDetailMovieViewController(result: result)
    }
}
