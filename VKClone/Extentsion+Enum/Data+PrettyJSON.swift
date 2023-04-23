//
//  Data+PrettyJSON.swift
//  RealProject
//
//  Created by Tanya on 16.05.2022.
//

import Foundation

// Data -> бинарные данные -> двоичные данные -> 101010110011

extension Data {
    
    var prettyJSON: NSString? { /// NSString give us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        
        return prettyPrintedString
    }
}
