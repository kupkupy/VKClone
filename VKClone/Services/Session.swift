//
//  Session.swift
//  RealProject
//
//  Created by Tanya on 04.05.2022.
//

import Foundation
import SwiftKeychainWrapper

final class Session {       //не разрешаем наследование
    private init() {}       //не разрешаем конструктор

    static let shared = Session()       //хранится в глобальной static-памяти (будет создан единожды и хранится в статической памяти)

    var token: String {
        get {
            //Keychain - хранилище на OC и зашифровано
            KeychainWrapper.standard.string(forKey: "token") ?? ""
        }
        set {
            KeychainWrapper.standard.set(newValue, forKey: "token")
        }
    }
    
    // для userID использовала propertyWrapper. Автосинтесизуемый код - компилятор, увидя вот эту внизу запись, подставит код, который написан в расширении (в UserDefault)
    @UserDefault(key: "userID") var userID: Int?
    
    lazy var tokenDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter
    }()

    //секунды жизни токена
    //  \Session.expiresIn -> метод/экстеншн
    var expiresIn: String {
        get {
            UserDefaults.standard.string(forKey: "expiresIn") ?? ""
        }
        set {
            //86400 секунд -> 4-июля-2022 15:00
            let tokenDate = Date(timeIntervalSinceNow: Double(newValue) ?? 0)

            //Дата срока токена в строковом формате
            let tokenDateString = tokenDateFormatter.string(from: tokenDate)

            UserDefaults.standard.set(tokenDateString, forKey: "expiresIn")
        }
    }
    
    var tokenIsValid: Bool {
        let currentDate = Date()
        guard let tokenDate = tokenDateFormatter.date(from: expiresIn) else { return false }
        print("curDate = ", currentDate)
        print("tokenDate = ", tokenDate)
        
        // Текущая дата меньше даты токена и токен вытаскивается из хранилища
        return currentDate < tokenDate && !token.isEmpty
    }
}

