//
//  URLParameterEncoding.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
public struct URLParameterEncoder: ParameterEncoder {
    
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                // Customisation for multiple param values with same url param key
                if let valueArr = value as? [Any] {
                    for eachValue in valueArr {
                        let queryItem = URLQueryItem(name: key,
                                                     value: "\(eachValue)".addingPercentEncoding(withAllowedCharacters:
                                                                                                .urlHostAllowed))
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)".addingPercentEncoding(withAllowedCharacters:
                                                                                            .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
    
    public func urlFormEncode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                // Customisation for multiple param values with same url param key
                if let valueArr = value as? [Any] {
                    for eachValue in valueArr {
                        let queryItem = URLQueryItem(name: key,
                                                     value: "\(eachValue)".addingPercentEncoding(withAllowedCharacters:
                                                            .urlHostAllowed))
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)".addingPercentEncoding(withAllowedCharacters:
                                                        .urlHostAllowed))
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.httpBody = urlComponents.query?.data(using: .utf8)
        }
        
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
    
    public func encodeWithoutPercent(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                // Customisation for multiple param values with same url param key
                if let valueArr = value as? [Any] {
                    for eachValue in valueArr {
                        let queryItem = URLQueryItem(name: key,
                                                     value: "\(eachValue)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key,
                                                 value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}
