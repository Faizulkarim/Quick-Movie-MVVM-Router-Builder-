//
//  AnalyticsScreen.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//
import Foundation

/// Data model representing a screen to be tracked by analytics service.
public struct AnalyticsScreen {
    
    // MARK: - Properties
    
    /// Name of the page.
    public let name: String
    
    /// Additional properties to be tracked, if available.
    public let properties: AnalyticsProperties?
    
    // MARK: - Init
    
    /// Creates new instance with provided details.
    ///
    /// - Parameter name: Name.
    public init(name: String) {
        self.init(name: name, properties: nil)
    }
    
    /// Creates new instance with provided details.
    ///
    /// - Parameters:
    ///   - name: Name.
    ///   - properties: Properties.s
    public init(name: String, properties: AnalyticsProperties?) {
        self.name = name
        self.properties = properties
    }
}
