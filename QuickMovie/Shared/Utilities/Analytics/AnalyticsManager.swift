//
//  AnalyticsManager.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//



import Foundation

/// Analytics manager protocol.
public protocol AnalyticsManager {
    
    /// Starts the analytics manager.
    func start()
    
    /// Tracks viewing of the provided screen.
    ///
    /// - Parameter screen: Screen.
    func track(screenView screen: AnalyticsScreen)
    
}

/// DefaultAnalyticsManager.
struct DefaultAnalyticsManager: AnalyticsManager {
    func start() {
        
    }
    
    func track(screenView screen: AnalyticsScreen) {
        
    }
}
