//
//  GroupTableViewCell.swift
//  RealProject
//
//  Created by Tanya on 17.05.2022.
//

import UIKit
import Alamofire

class GroupCell: UITableViewCell {
    
    let groupAvatarImageViewHeight: CGFloat = 60

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    lazy var groupNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "Group"
        return label
    }()
    
    lazy var groupStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var groupSubscribersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var groupAvatarImageView: UIImageView = {
        let image = UIImage(systemName: "person.crop.circle.fill")
        let imageView = UIImageView(image: image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = groupAvatarImageViewHeight / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configureGroup(_ model: Group) {
        self.groupNameLabel.text = model.name
        self.groupSubscribersLabel.text = String(model.membersCount ?? 0) + " подписч."
        self.groupStatusLabel.text = model.status
        self.groupAvatarImageView.sd_setImage(with: URL(string: model.photo100), completed: nil)
    }

    func layout() {
        contentView.addSubview(groupNameLabel)
        contentView.addSubview(groupStatusLabel)
        contentView.addSubview(groupSubscribersLabel)
        contentView.addSubview(groupAvatarImageView)
        
        NSLayoutConstraint.activate([
            groupAvatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            groupAvatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            groupAvatarImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            groupAvatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            groupAvatarImageView.heightAnchor.constraint(equalToConstant: 60),
            groupAvatarImageView.widthAnchor.constraint(equalTo: groupAvatarImageView.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            groupNameLabel.leadingAnchor.constraint(equalTo: groupAvatarImageView.trailingAnchor, constant: 8),
            groupNameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            groupNameLabel.topAnchor.constraint(equalTo: groupAvatarImageView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            groupSubscribersLabel.centerYAnchor.constraint(equalTo: groupAvatarImageView.centerYAnchor),
            groupSubscribersLabel.leadingAnchor.constraint(equalTo: groupAvatarImageView.trailingAnchor, constant: 8),
            groupSubscribersLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            groupStatusLabel.leadingAnchor.constraint(equalTo: groupAvatarImageView.trailingAnchor, constant: 8),
            groupStatusLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            groupStatusLabel.bottomAnchor.constraint(equalTo: groupAvatarImageView.bottomAnchor)
        ])
    }

}
