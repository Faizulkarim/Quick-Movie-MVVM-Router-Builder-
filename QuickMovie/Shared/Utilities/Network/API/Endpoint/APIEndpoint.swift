//
//  APIEndpoint.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//

import Foundation


public enum APIEndpoint {
    case nowPlaying
    case trendingMovie
    case relatedMovie(id: String)
    case popularMovie(param: Parameters)
    case upcomingMovie(param: Parameters)
}
extension APIEndpoint: EndPointType {
    
    var environmentBaseURL : String {
        return Constants.baseUrl
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
           
        case .trendingMovie:
            return "trending/movie/day"
            
        case .relatedMovie(let id):
            return "movie/\(id)/similar"
            
        case .popularMovie:
            return "movie/popular"
        
        case .upcomingMovie:
            return "movie/now_playing"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {

        case .nowPlaying:
            return .get
        case .trendingMovie:
            return .get
        case .relatedMovie:
            return .get
        case .popularMovie:
            return .get
        
        case .upcomingMovie:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .nowPlaying:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        case .trendingMovie:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
        case .relatedMovie:
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .jsonEncoding, urlParameters: nil, additionHeaders: headers)
            
        case .popularMovie(let params):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: headers)
            
        case .upcomingMovie(let params):
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params, additionHeaders: headers)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self  {
        case .nowPlaying:
            return Constants.authToken
        case .trendingMovie:
            return Constants.authToken
        case .relatedMovie:
            return Constants.authToken
        case .popularMovie:
            return Constants.authToken
        case .upcomingMovie:
            return Constants.authToken
        }
    }
    
}
