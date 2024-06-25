//
//  EndPointType.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
