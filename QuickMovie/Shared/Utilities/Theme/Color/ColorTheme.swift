//
//  ColorTheme.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import UIKit

protocol ColorTheme {
    var clearColor: UIColor { get }
    var colorPrimaryWhite : UIColor? { get }
    var colorPrimaryBlack : UIColor? { get }
    var colorPrimaryRed : UIColor? { get }
    var colorLightGray: UIColor? { get }
}
