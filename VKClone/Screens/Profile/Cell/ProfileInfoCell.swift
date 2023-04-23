//
//  ProfileInfoCell.swift
//  RealProject
//
//  Created by Tanya on 12.06.2022.
//

import UIKit
import SkeletonView

class ProfileInfoCell: UITableViewCell {

    lazy var educationLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.text = "Место учебы: "
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var educationImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "graduationcap"))
        imageView.isSkeletonable = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var bdateLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.lastLineFillPercent = 90
        label.linesCornerRadius = 5
        label.text = "Дата рождения: "
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bdateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "calendar"))
        imageView.isSkeletonable = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.lastLineFillPercent = 90
        label.linesCornerRadius = 5
        label.text = "Город: "
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var cityImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "homekit"))
        imageView.isSkeletonable = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 6
        imageView.tintColor = .darkGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        activateConstraints()
        
        
        contentView.isSkeletonable = true
        contentView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                               animation: nil,
                                               transition: .crossDissolve(0.3))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func activateConstraints() {
        contentView.addSubview(educationLabel)
        contentView.addSubview(educationImageView)
        contentView.addSubview(bdateLabel)
        contentView.addSubview(bdateImageView)
        contentView.addSubview(cityLabel)
        contentView.addSubview(cityImageView)
        
        NSLayoutConstraint.activate([
            bdateImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            bdateImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bdateImageView.heightAnchor.constraint(equalToConstant: 24),
            bdateImageView.widthAnchor.constraint(equalTo: bdateImageView.heightAnchor, multiplier: 1),
            bdateLabel.centerYAnchor.constraint(equalTo: bdateImageView.centerYAnchor),
            bdateLabel.leadingAnchor.constraint(equalTo: bdateImageView.trailingAnchor, constant: 16),
            bdateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            cityImageView.topAnchor.constraint(equalTo: bdateImageView.bottomAnchor, constant: 16),
            cityImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            cityImageView.heightAnchor.constraint(equalToConstant: 24),
            cityImageView.widthAnchor.constraint(equalTo: cityImageView.heightAnchor, multiplier: 1),
            cityLabel.centerYAnchor.constraint(equalTo: cityImageView.centerYAnchor),
            cityLabel.leadingAnchor.constraint(equalTo: cityImageView.trailingAnchor, constant: 16),
            cityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            educationImageView.topAnchor.constraint(equalTo: cityImageView.bottomAnchor, constant: 16),
            educationImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            educationImageView.heightAnchor.constraint(equalToConstant: 24),
            educationImageView.widthAnchor.constraint(equalTo: educationImageView.heightAnchor, multiplier: 1),
            educationLabel.centerYAnchor.constraint(equalTo: educationImageView.centerYAnchor),
            educationLabel.leadingAnchor.constraint(equalTo: educationImageView.trailingAnchor, constant: 16),
            educationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            educationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    //MARK: - Public
    //Передаем информацию о профиле (др, город, образование)
    func configure(_ model: Profile) {
        self.bdateLabel.text! += (model.bdate.isNull) ? "" : model.bdate
        self.cityLabel.text! += (model.city.title.isNull) ? "" : "\(model.city.title), \(model.country.title)"
        self.educationLabel.text! += (model.universityName.isNull) ? "" : model.universityName
        
        hideSkeletonView()
    }
    
    func hideSkeletonView() {
        
        educationLabel.hideSkeleton()
        educationLabel.isSkeletonable = false
        educationImageView.hideSkeleton()
        educationImageView.isSkeletonable = false
        
        bdateLabel.hideSkeleton()
        bdateLabel.isSkeletonable = false
        bdateImageView.hideSkeleton()
        bdateImageView.isSkeletonable = false
        
        cityLabel.hideSkeleton()
        cityLabel.isSkeletonable = false
        cityImageView.hideSkeleton()
        cityImageView.isSkeletonable = false

        contentView.layoutIfNeeded()
    }
}
