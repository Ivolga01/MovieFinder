//
//  SearchMovieCell.swift
//  MovieFinder
//
//  Created by Тамара Иволга on 13.03.2022.
//

import UIKit

class SearchMovieCell: UITableViewCell {
    
    let networkService = NetworkService()
    
    private lazy var contentImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        //image.clipsToBounds = true
        //image.layer.cornerRadius = 8
        //image.backgroundColor = Constants.Colors.contentColor
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Fonts.semiBold16
        label.textColor = Constants.Colors.textColor
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.Fonts.regular14
        label.textColor = Constants.Colors.textColor
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(contentImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(390)
        }
        
        contentImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalTo(contentImage.snp.right).offset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(contentImage.snp.right).offset(16)
            make.right.equalToSuperview().inset(16)
        }
    }
    
    func configure(model: Results) {
        titleLabel.text = model.title
        descriptionLabel.text = model.resultDescription
        
        networkService.getImage(urlImage: model.image) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.contentImage.image = UIImage(data: data)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
