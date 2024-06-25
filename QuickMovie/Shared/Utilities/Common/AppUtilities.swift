//
//  AppUtilities.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 19/6/24.
//

import Foundation

class AppUtilities: NSObject {
    
    static let shared = AppUtilities()
    
    func convertMovieReleaseDate(dateString: String, dateFormate: String = "MMMM dd, yyyy") -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = dateFormate
           return dateFormatter.string(from: date)
        } else {
            return ""
        }

    }
    
}
