//
//  DetailMoviePresenter.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 08.06.2022.
//

import Foundation

protocol DetailMovieViewProtocol: AnyObject {
    func startActivityIndicator()
    func showDetailMovie(imageData: Data)
}

protocol DetailMovieViewPresenterProtocol: AnyObject {
    init(view: DetailMovieViewProtocol, networkService: NetworkServiceProtocol, resultSearch: Results?, router: RouterProtocol)
    var resultSearch: Results? { get set }
    func getImage()
}

class DetailMoviePresenter: DetailMovieViewPresenterProtocol {
    weak var view: DetailMovieViewProtocol!
    let networkService: NetworkServiceProtocol!
    let router: RouterProtocol!
    
    var resultSearch: Results?
    
    required init(view: DetailMovieViewProtocol, networkService: NetworkServiceProtocol, resultSearch: Results?, router: RouterProtocol) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.resultSearch = resultSearch
        getImage()
    }
    
    func getImage() {
        view.startActivityIndicator()
        
        guard let urlImage = resultSearch?.image else { return }
        
        networkService.getImage(urlImage: urlImage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.view.showDetailMovie(imageData: data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
