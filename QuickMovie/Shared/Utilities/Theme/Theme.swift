//
//  Theme.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
protocol Theme {
    /// Color theme object.
    var colorTheme: ColorTheme { get set }
    
    /// Font theme object.
    var fontTheme: FontTheme { get set }
    var imageTheme: ImageTheme {get set}

   
}
