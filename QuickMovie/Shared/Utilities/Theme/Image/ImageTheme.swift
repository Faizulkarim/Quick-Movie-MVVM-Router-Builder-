//
//  ImageTheme.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation
import UIKit

protocol ImageTheme {
    var navBack : UIImage{get}
    var tabbar_home: UIImage{get}
    var tabbar_Fav: UIImage{get}
    var favoriteEmpty: UIImage { get }
    var favoriteFil : UIImage{ get }
}
