//
//  FriendsTableViewCell.swift
//  RealProject
//
//  Created by Tanya on 11.05.2022.
//

import UIKit
import Alamofire
import SDWebImage

class FriendCell: UITableViewCell {
    
    private let profilePhotoHeight: CGFloat = 40
    private let onlineStatusHeight: CGFloat = 10
    
    lazy var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 2
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Name"
        return label
    }()
    
    lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.text = "City"
        return label
    }()
    
    lazy var profilePhotoImageView: UIImageView = {
        let image = UIImage(systemName: "person.crop.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = profilePhotoHeight / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    lazy var onlineStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = onlineStatusHeight / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - Lifecycle
    
    override func prepareForReuse() {
        onlineStatusImageView.image = nil
        profilePhotoImageView.image = nil
        cityLabel.text = nil
        fullNameLabel.text = nil
        onlineStatusImageView.backgroundColor = .clear
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    func layout() {
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(cityLabel)
        contentView.addSubview(profilePhotoImageView)
        contentView.addSubview(onlineStatusImageView)
        
        NSLayoutConstraint.activate([
            profilePhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            profilePhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            profilePhotoImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profilePhotoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profilePhotoImageView.heightAnchor.constraint(equalToConstant: 40),
            profilePhotoImageView.widthAnchor.constraint(equalTo: profilePhotoImageView.heightAnchor, multiplier: 1),
            fullNameLabel.topAnchor.constraint(equalTo: profilePhotoImageView.topAnchor),
            fullNameLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: 8),
            cityLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 4),
            cityLabel.leadingAnchor.constraint(equalTo: profilePhotoImageView.trailingAnchor, constant: 8),
            onlineStatusImageView.leadingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor, constant: 4),
            onlineStatusImageView.centerYAnchor.constraint(equalTo: fullNameLabel.centerYAnchor),
            onlineStatusImageView.heightAnchor.constraint(equalToConstant: 10),
            onlineStatusImageView.widthAnchor.constraint(equalTo: onlineStatusImageView.heightAnchor, multiplier: 1)
        ])
    }
    //photoURL: String, firstName: String, lastName: String, city: String, onlineStatus: Int
    func configureFriends(_ model: Friend) {
        profilePhotoImageView.sd_setImage(with: URL(string: model.photo100), completed: nil)
        fullNameLabel.text = "\(model.firstName) \(model.lastName)"
        cityLabel.text = model.city?.title
        
        if model.online == 1 {
            onlineStatusImageView.backgroundColor = .systemGreen
        }
    }
    
}
