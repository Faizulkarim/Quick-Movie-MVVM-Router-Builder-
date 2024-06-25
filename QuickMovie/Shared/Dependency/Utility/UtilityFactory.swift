//
//  UtilityFactory.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
protocol UtilityFactory {
    func launchSequencer() -> LaunchSequencer
    func analyticsManager() -> AnalyticsManager
    func apiManager() -> OTAPIManager
    func theme() -> Theme
}
