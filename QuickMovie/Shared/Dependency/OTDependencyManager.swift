//
//  OTDependencyManager.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
import UIKit

final class OTDependencyManager {
    static let defaultValue =  OTDependencyManager()
    private var rootWindow: UIWindow?
    private var _launchSequencer: LaunchSequencer?
    private var _sharedAnalyticsManager: AnalyticsManager?
    private var _apiManager: OTAPIManager?
    private var _theme: Theme?
}

extension OTDependencyManager: DependencyManager {
    // MARK: - Instance functions
    
    func configure(rootWindow: UIWindow?) {
    
        self.rootWindow = rootWindow
    }
    
    private func clear() {
        self._theme = nil
        self._launchSequencer = nil
    }
}

// MARK: Utility Factory Protocol Implementaion
extension OTDependencyManager {
    
    func apiManager() -> OTAPIManager {
        return _apiManager ?? OTAPIManager()
    }
        
    func launchSequencer() -> LaunchSequencer {
        if _launchSequencer == nil {
            _launchSequencer = LaunchSequencer(rootWindow: rootWindow,
                                               dependencyManager: self)
        }
        return _launchSequencer!
    }
    
    func analyticsManager() -> AnalyticsManager {
        if _sharedAnalyticsManager == nil {
            _sharedAnalyticsManager = DefaultAnalyticsManager()
        }

        return _sharedAnalyticsManager!
    }
    
    func theme() -> Theme {
        if _theme == nil {
            let colorTheme: ColorTheme = OTColorTheme()
            let fontTheme: FontTheme = OTFontTheme()
            let imageTheme: ImageTheme = OTImageTheme()
   
            
            _theme = DefaultTheme(colorTheme: colorTheme,
                                  fontTheme: fontTheme, imageTheme: imageTheme)
        }
        return _theme!
    }
    
}
