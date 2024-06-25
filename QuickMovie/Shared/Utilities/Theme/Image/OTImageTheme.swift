//
//  OTImageTheme.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation
import UIKit
struct OTImageTheme: ImageTheme {
    
    var navBack: UIImage {
        guard let image = UIImage(systemName: "arrowshape.backward.fill") else {
            fatalError("Missing image: Back")
        }
        return image
    }

    var tabbar_home: UIImage {
        guard let image = UIImage(systemName: "movieclapper") else {
            fatalError("Missing image: movieclapper")
        }
        return image
    }

    var tabbar_Fav: UIImage {
        guard let image = UIImage(systemName: "heart.circle") else {
            fatalError("Missing image: heart.circle")
        }
        return image
    }
    
    var favoriteEmpty: UIImage {
        guard let image = UIImage(systemName: "heart")else {
            fatalError("Missing image: heart")
        }
        return image
    }
    
    var favoriteFil: UIImage {
        guard let image = UIImage(systemName: "heart.fill")else {
            fatalError("Missing image: heart.fill")
        }
        return image
    }
}
