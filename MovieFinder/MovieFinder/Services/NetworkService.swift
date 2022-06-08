//
//  NetworkService.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 07.06.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func getResults(searchText: String, completion: @escaping (Result<ResultSearch?, Error>) -> Void)
    func getImage(urlImage: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func getResults(searchText: String, completion: @escaping (Result<ResultSearch?, Error>) -> Void) {
        let urlString = "https://imdb-api.com/API/Search/k_l0a8qv0w/"
        guard let url = URL(string: urlString + searchText) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                guard let data = data else {
                    return
                }

                do {
                    let result = try JSONDecoder().decode(ResultSearch.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getImage(urlImage: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlImage) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            } else {
                if let data = data {
                    completion(.success(data))
                }
            }
        }.resume()
    }
}
