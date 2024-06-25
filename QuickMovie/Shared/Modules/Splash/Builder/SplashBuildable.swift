//
//  SplashBuildable.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//
import Foundation
import UIKit

/// Splash builder protocol.
protocol SplashBuildable {

    /// Builds the Splash view.
    ///
    /// - Returns: Splash details view.
    func build() -> UIViewController

}
