//
//  ProfileHeader.swift
//  RealProject
//
//  Created by Tanya on 09.06.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    let identifier = "ProfileHeaderView"
    
    let avatarHeight: CGFloat = 130
    private let onlineStatusHeight: CGFloat = 10
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "photo.circle"))
        imageView.isSkeletonable = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = avatarHeight / 2
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var fulltNameLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.lastLineFillPercent = 90
        label.linesCornerRadius = 5
        label.text = ""
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.lastLineFillPercent = 90
        label.linesCornerRadius = 5
        label.text = "Status"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var onlineStatusLabel: UILabel = {
        let label = UILabel()
        label.isSkeletonable = true
        label.lastLineFillPercent = 90
        label.linesCornerRadius = 5
        label.text = "В сети"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var onlineStatusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isSkeletonable = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = onlineStatusHeight / 2
        imageView.backgroundColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let backImageView: UIImageView = {
        let backView = UIImageView(image: UIImage(named: "background"))
        backView.contentMode = .scaleAspectFill
        backView.clipsToBounds = true
        backView.translatesAutoresizingMaskIntoConstraints = false
        return backView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        activateConstraints()
        isSkeletonable = true
        
        showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .lightGray),
                                               animation: nil,
                                               transition: .none)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func activateConstraints() {
        addSubview(profileImageView)
        addSubview(fulltNameLabel)
        addSubview(onlineStatusLabel)
        addSubview(onlineStatusImageView)
        addSubview(statusLabel)
        addSubview(backImageView)
        sendSubviewToBack(backImageView)
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            profileImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8),
            profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileImageView.heightAnchor.constraint(equalToConstant: 130),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            fulltNameLabel.centerYAnchor.constraint(equalTo: onlineStatusLabel.centerYAnchor, constant: -26),
            fulltNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            fulltNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            onlineStatusLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            onlineStatusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            onlineStatusImageView.leadingAnchor.constraint(equalTo: onlineStatusLabel.trailingAnchor, constant: 4),
            onlineStatusImageView.centerYAnchor.constraint(equalTo: onlineStatusLabel.centerYAnchor),
            onlineStatusImageView.heightAnchor.constraint(equalToConstant: 10),
            onlineStatusImageView.widthAnchor.constraint(equalTo: onlineStatusImageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            statusLabel.centerYAnchor.constraint(equalTo: onlineStatusLabel.centerYAnchor, constant: 26),
            statusLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setup(_ modelArray: [Profile]) {
        
        if let model = modelArray.first {
            self.profileImageView.sd_setImage(with: URL(string: model.photo100))
            self.fulltNameLabel.text! += "\(model.firstName) \(model.lastName)"
        }
    }
}
