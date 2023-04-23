//
//  FriendDelegate.swift
//  vk-tanya
//
//  Created by Tanya on 07.07.2022.
//

import UIKit

class FriendTableViewDelegate: NSObject, UITableViewDelegate {
    
    //Это свойство будет использоваться, чтобы сообщить вью контроллеру, когда ячейка была нажата.
    weak var delegate: FriendVCDelegate?
    
    //создаем собственный инициализатор, который принимает делегат в качестве аргумента и присваивает его свойству делегата, чтобы мы могли использовать его позже.
    init(withDelegate delegate: FriendVCDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.selectedCell(row: indexPath.row)
    }
}
