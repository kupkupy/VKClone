//
//  UITableViewCell+Reusable.swift
//  RealProject
//
//  Created by Artur Igberdin on 03.06.2022.
//

import UIKit

protocol Reusable {
    
}

extension Reusable where Self: UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension Reusable where Self: UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}

extension UICollectionViewCell: Reusable {}
