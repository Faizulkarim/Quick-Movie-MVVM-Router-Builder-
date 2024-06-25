//
//  UIViewController+Extension.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation
import UIKit
extension UIViewController {
    static var statusBarHeight: CGFloat {
        var top: CGFloat = 0.0
        if #available(iOS 13.0, *) {
            top += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            top += UIApplication.shared.statusBarFrame.height
        }
        return top
    }
    
    var topBarHeight: CGFloat {
        return (self.navigationController?.navigationBar.frame.height ?? 0.0) + UIViewController.statusBarHeight
    }
}

