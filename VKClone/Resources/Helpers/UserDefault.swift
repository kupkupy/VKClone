//
//  UserDefault.swift
//  vk-tanya
//
//  Created by Tanya on 29.08.2022.
//

import Foundation

@propertyWrapper // обертка на переменную, у которой добавляется какой-то доп.функционал
struct UserDefault<T> {
    
    private let key: String
    
    // ключ прокинем через инициализатор
    init(key: String) {
        self.key = key
    }
    
    // это обертывающая переменная
    var wrappedValue: T? {
        get {
            UserDefaults.standard.value(forKey: self.key) as? T //кастим до нашего типа
        }
        set {
            UserDefaults.standard.set(newValue, forKey: self.key)
        }
    }
}
