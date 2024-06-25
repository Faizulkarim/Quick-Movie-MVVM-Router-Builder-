//
//  OTParameterEncoding.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

public enum ParameterEncoding {

    case none
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    case urlFormEncoding

    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        do {
            switch self {
            case .none:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encodeWithoutPercent(urlRequest: &urlRequest, with: urlParameters)

            case .urlFormEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try URLParameterEncoder().urlFormEncode(urlRequest: &urlRequest, with: bodyParameters)

            case .urlEncoding:
                guard let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                
            case .jsonEncoding:
                guard let bodyParameters = bodyParameters else { return }
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            case .urlAndJsonEncoding:
                guard let bodyParameters = bodyParameters,
                    let urlParameters = urlParameters else { return }
                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: urlParameters)
                try JSONParameterEncoder().encode(urlRequest: &urlRequest, with: bodyParameters)
                
            }
        } catch {
            throw error
        }
    }
}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}
