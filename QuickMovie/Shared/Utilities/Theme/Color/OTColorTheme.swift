//
//  OTColorTheme.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import UIKit

struct OTColorTheme: ColorTheme {
    var clearColor: UIColor {
        return .clear
    }
    var colorPrimaryWhite : UIColor? {
        return UIColor.init(named: "PrimaryWhite")
    }
    
    var colorPrimaryBlack : UIColor? {
        return UIColor.init(named: "PrimaryBlack")
    }
    
    var colorPrimaryRed: UIColor? {
        return UIColor.init(named: "PrimaryRed")
    }
    
    var colorLightGray: UIColor? {
        return UIColor.init(named: "ColorLightGray")
    }
    
}
