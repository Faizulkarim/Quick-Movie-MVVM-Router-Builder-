//
//  LocalizationKey.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation

protocol LocalizedStringProvider {
   func value() -> String
}

enum LocalizationKey {
    
    enum NetworkError: String, LocalizedStringProvider {
        case ConnectionLostTitle = "No Internet Connection"
        case ConnectionLostDesc = "Please connect your device to internet."
        case InvalidUrlTitle = "Invalid Url"
        case InvalidUrlDesc = "Please try after some time."
        case parsingError = "Parsing Error"
        case parsingErrorDes = "Unable to parse json response."
        
        func value() -> String {
            rawValue.localizedString()
        }
    }
    
    enum CommonError: String, LocalizedStringProvider {
        case oops = "OOPS !!"
        
        
        func value() -> String {
            rawValue.localizedString()
        }
    }
    
    
}
