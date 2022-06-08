//
//  DetailMovieViewController.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 08.06.2022.
//

import UIKit

class DetailMovieViewController: UIViewController {
    
    var presenter: DetailMovieViewPresenterProtocol!
    
    private lazy var photoView: UIView = {
        let view = UIView()
        view.layer.borderColor = Constants.Colors.borderColor?.cgColor
        view.layer.borderWidth = 0.5
        return view
    }()
    
    private lazy var imageMovie: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    private lazy var titleMovie: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBold18
        label.textColor = Constants.Colors.textColor
        return label
    }()
    
    private lazy var descriptionMovie: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.Fonts.regular16
        label.textColor = Constants.Colors.textColor
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(photoView.snp.width)
        }
        
        photoView.addSubview(imageMovie)
        imageMovie.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        photoView.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.height.width.equalTo(44)
            make.center.equalToSuperview()
        }
        
        view.addSubview(titleMovie)
        titleMovie.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(16)
        }
        
        view.addSubview(descriptionMovie)
        descriptionMovie.snp.makeConstraints { make in
            make.top.equalTo(titleMovie.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
        }
    }
}

extension DetailMovieViewController: DetailMovieViewProtocol {
    func startActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func showDetailMovie(imageData: Data) {
        let detailMovie = presenter.resultSearch
        
        titleMovie.text = detailMovie?.title
        descriptionMovie.text = detailMovie?.resultDescription
        imageMovie.image = UIImage(data: imageData)
        
        imageMovie.isHidden = false
        activityIndicator.stopAnimating()
    }
}
