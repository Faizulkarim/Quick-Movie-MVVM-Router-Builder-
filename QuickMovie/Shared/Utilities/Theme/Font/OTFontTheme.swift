//
//  OTFontTheme.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import UIKit

struct OTFontTheme: FontTheme {
    var regularMontserrat: MontserratFonts = MontserratFonts.Regular
    var mediumMontserrat: MontserratFonts = MontserratFonts.medium
    var semiboldMontserrat: MontserratFonts = MontserratFonts.semiBold
}

enum MontserratFonts: String {
    case Regular = "Montserrat-Regular"
    case medium = "Montserrat-Medium"
    case semiBold = "Montserrat-SemiBold"

    func font(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}
