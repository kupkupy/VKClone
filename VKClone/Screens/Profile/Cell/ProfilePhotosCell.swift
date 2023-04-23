//
//  ProfilePhotosCell.swift
//  RealProject
//
//  Created by Tanya on 17.06.2022.
//

import UIKit
import SDWebImage

class ProfilePhotosCell: UITableViewCell {
    
    let photoImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let photoImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let photoImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let photoImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemPurple
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let photosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.isSkeletonable = true
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.textColor = .black
        label.text = "Фотографии"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let photosCounterLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.textColor = .darkGray
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let transitionButton: UIButton = {
        let button = UIButton()
        button.isSkeletonable = true
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        contentView.isSkeletonable = true
        contentView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                               animation: nil,
                                               transition: .crossDissolve(0.3))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupCell() {
        contentView.addSubview(photosStackView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(photosCounterLabel)
        contentView.addSubview(transitionButton)
        photosStackView.addArrangedSubview(photoImageView1)
        photosStackView.addArrangedSubview(photoImageView2)
        photosStackView.addArrangedSubview(photoImageView3)
        photosStackView.addArrangedSubview(photoImageView4)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            photosStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            photosStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            photosStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photosStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            photoImageView1.heightAnchor.constraint(equalTo: photoImageView1.widthAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            photosCounterLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            photosCounterLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            transitionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            transitionButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            transitionButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        ])
    }
    
    //MARK: - Public
    //Передаем количество фотографий
    func configure(_ modelArray: [Profile]) {
        //придет словарь с одним элементом "photos": 34 (число может меняться), поэтому ниже словарь counters.
        var counters: [String : Int] = [:]
        
        modelArray.forEach { item in
            counters = item.counters
        }
        
        for (_, _) in counters {
            self.photosCounterLabel.text = String(counters["photos"]!)
        }
        
        hideSkeletonView()
    }
    
    func hideSkeletonView() {
        photoImageView1.hideSkeleton()
        photoImageView1.isSkeletonable = false
        
        photoImageView2.hideSkeleton()
        photoImageView2.isSkeletonable = false
        
        photoImageView3.hideSkeleton()
        photoImageView3.isSkeletonable = false
        
        photoImageView4.hideSkeleton()
        photoImageView4.isSkeletonable = false
        
        photosStackView.hideSkeleton()
        photosStackView.isSkeletonable = false
        
        titleLabel.hideSkeleton()
        titleLabel.isSkeletonable = false
        
        photosCounterLabel.hideSkeleton()
        photosCounterLabel.isSkeletonable = false
        
        transitionButton.hideSkeleton()
        transitionButton.isSkeletonable = false

        contentView.layoutIfNeeded()
    }
}
