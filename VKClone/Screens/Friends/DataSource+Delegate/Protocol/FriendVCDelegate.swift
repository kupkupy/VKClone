//
//  FriendVCDelegate.swift
//  vk-tanya
//
//  Created by Tanya on 07.07.2022.
//

import Foundation

//нам нужно создать протокол, который мы будем использовать для связи между классами TableViewDelegate и ViewController.
protocol FriendVCDelegate: AnyObject {
    
    //Метод selectedCell позволит нам сообщить ViewController, какую ячейку нажал пользователь.
    func selectedCell(row: Int)
}
