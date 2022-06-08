//
//  ViewController.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 13.03.2022.
//

import UIKit
import SnapKit

class SearchMovieViewController: UIViewController {
    
    var presenter: SearchMovieViewPresenterProtocol!
    
    let cellViewController = "SearchMovieCell"
    
    private lazy var movieSearchBar: UISearchBar = {
        let seacrh = UISearchBar()
        seacrh.delegate = self
        return seacrh
    }()
    
    private lazy var moviesTableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(SearchMovieCell.self, forCellReuseIdentifier: cellViewController)
        table.isHidden = true
        return table
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        title = Constants.Text.title
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .white
    }

    private func setupConstraints() {
        view.addSubview(movieSearchBar)
        movieSearchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(moviesTableView)
        moviesTableView.snp.makeConstraints { make in
            make.top.equalTo(movieSearchBar.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

extension SearchMovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.resultSearch?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewController) as? SearchMovieCell
        guard let result = presenter.resultSearch?[indexPath.row] else { return UITableViewCell() }
        cell?.configure(model: result)
        return cell ?? UITableViewCell()
    }
}

extension SearchMovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let result = presenter.resultSearch?[indexPath.row] else { return }
        presenter.tapOnTheMovie(result: result)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        moviesTableView.isHidden = true
        activityIndicator.startAnimating()
        if let searchText = searchBar.text {
            presenter.getResultSearch(searchText: searchText)
        }
        view.endEditing(true)
    }
}

extension SearchMovieViewController: SearchMovieViewProtocol {
    func successData() {
        moviesTableView.reloadData()
        
        moviesTableView.isHidden = false
        activityIndicator.stopAnimating()
    }
}
