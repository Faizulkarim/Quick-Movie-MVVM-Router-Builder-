//
//  BaseNavigationViewController.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation
import UIKit

class BaseNavigationViewController: UINavigationController {}

extension BaseNavigationViewController {
    
    static func createObj(with rootVC: UIViewController) -> BaseNavigationViewController  {
        let baseStoryBoard = UIStoryboard(name: "BaseStoryboard", bundle: Bundle.main)
        let baseNavigationViewController = baseStoryBoard.instantiateViewController(withIdentifier: "BaseNavigationViewController") as! BaseNavigationViewController
        baseNavigationViewController.viewControllers = [rootVC]
        return baseNavigationViewController
    }
    
}

