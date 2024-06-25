//
//  OTAPIManager.swift
//  QuickMovie
//
//  Created by Md Faizul karim on 18/6/24.
//


import Foundation
import Combine

struct OTAPIManager {
    /// Router to call custom get/post request via Middleware
    let router: Router<APIEndpoint> = Router<APIEndpoint>()
}

// ----------------------------------
// MARK: - Middleware Calls
//

extension OTAPIManager {
    @discardableResult
    func nowPlaying() -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> {
        return Deferred {
            Future { promise in
                self.router.request(APIEndpoint.nowPlaying) { data, _ , error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        promise(.success(Result.failure(OTError(fromError: error as NSError))))
                    } else {
                        
                        if let validResponse = MovieResponseModel.decode(data: data) {
                            
                            
                            if validResponse.success ?? true {
                                promise(.success(Result.success(validResponse)))
                            } else {
                                let customError = OTError(statusCode: 200, title: LocalizationKey.CommonError.oops.value(), body: validResponse.status_message)
                                promise(.success(Result.failure(customError)))
                            }
                            
                        } else {
                            let customError = OTError(statusCode: -1, title: LocalizationKey.NetworkError.parsingError.value(),body: LocalizationKey.NetworkError.parsingErrorDes.value())
                            promise(.success(Result.failure(customError)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    @discardableResult
    func trendingMovie() -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> {
        return Deferred {
            Future { promise in
                self.router.request(APIEndpoint.trendingMovie) { data, _ , error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        promise(.success(Result.failure(OTError(fromError: error as NSError))))
                    } else {
                        
                        if let validResponse = MovieResponseModel.decode(data: data) {
                            
                            
                            if validResponse.success ?? true {
                                promise(.success(Result.success(validResponse)))
                            } else {
                                let customError = OTError(statusCode: 200, title: LocalizationKey.CommonError.oops.value(), body: validResponse.status_message)
                                promise(.success(Result.failure(customError)))
                            }
                            
                        } else {
                            let customError = OTError(statusCode: -1, title: LocalizationKey.NetworkError.parsingError.value(),body: LocalizationKey.NetworkError.parsingErrorDes.value())
                            promise(.success(Result.failure(customError)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    
    @discardableResult
    func relatedMovie(_ id: String) -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> {
        return Deferred {
            Future { promise in
                self.router.request(APIEndpoint.relatedMovie(id: id)) { data, _ , error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        promise(.success(Result.failure(OTError(fromError: error as NSError))))
                    } else {
                        
                        if let validResponse = MovieResponseModel.decode(data: data) {
                            
                            
                            if validResponse.success ?? true {
                                promise(.success(Result.success(validResponse)))
                            } else {
                                let customError = OTError(statusCode: 200, title: LocalizationKey.CommonError.oops.value(), body: validResponse.status_message)
                                promise(.success(Result.failure(customError)))
                            }
                            
                        } else {
                            let customError = OTError(statusCode: -1, title: LocalizationKey.NetworkError.parsingError.value(),body: LocalizationKey.NetworkError.parsingErrorDes.value())
                            promise(.success(Result.failure(customError)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    @discardableResult
    func popularMovie(param: Parameters) -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> {
        return Deferred {
            Future { promise in
                self.router.request(APIEndpoint.popularMovie(param: param)) { data, _ , error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        promise(.success(Result.failure(OTError(fromError: error as NSError))))
                    } else {
                        
                        if let validResponse = MovieResponseModel.decode(data: data) {
                            
                            
                            if validResponse.success ?? true {
                                promise(.success(Result.success(validResponse)))
                            } else {
                                let customError = OTError(statusCode: 200, title: LocalizationKey.CommonError.oops.value(), body: validResponse.status_message)
                                promise(.success(Result.failure(customError)))
                            }
                            
                        } else {
                            let customError = OTError(statusCode: -1, title: LocalizationKey.NetworkError.parsingError.value(),body: LocalizationKey.NetworkError.parsingErrorDes.value())
                            promise(.success(Result.failure(customError)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
    @discardableResult
    func upcomingMovie(param: Parameters) -> AnyPublisher<Result<MovieResponseModel?, OTError>, Never> {
        return Deferred {
            Future { promise in
                self.router.request(APIEndpoint.upcomingMovie(param: param)) { data, _ , error in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        promise(.success(Result.failure(OTError(fromError: error as NSError))))
                    } else {
                        
                        if let validResponse = MovieResponseModel.decode(data: data) {
                            
                            
                            if validResponse.success ?? true {
                                promise(.success(Result.success(validResponse)))
                            } else {
                                let customError = OTError(statusCode: 200, title: LocalizationKey.CommonError.oops.value(), body: validResponse.status_message)
                                promise(.success(Result.failure(customError)))
                            }
                            
                        } else {
                            let customError = OTError(statusCode: -1, title: LocalizationKey.NetworkError.parsingError.value(),body: LocalizationKey.NetworkError.parsingErrorDes.value())
                            promise(.success(Result.failure(customError)))
                        }
                    }
                }
            }
        }.eraseToAnyPublisher()
    }
    
}


struct OTErrorArray: Codable {
    var errors: [OTError]?
    
    enum CodingKeys: String, CodingKey {
        case errors
    }
}

struct OTError: Error, Codable {
    var statusCode: Int?
    var title: String?
    var body: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode
        case title
        case body
    }
}

extension OTError {
    
    init(fromError: NSError) {
        self.init()
        self.statusCode = fromError.code
        if fromError.code == NSURLErrorNotConnectedToInternet || fromError.code == NSURLErrorNetworkConnectionLost  || fromError.code == 503 {
            self.title = LocalizationKey.NetworkError.ConnectionLostTitle.value()
            self.body = LocalizationKey.NetworkError.ConnectionLostDesc.value()
        } else if fromError.code == NSURLErrorBadURL {
            self.title = LocalizationKey.NetworkError.InvalidUrlTitle.value()
            self.body = LocalizationKey.NetworkError.InvalidUrlDesc.value()
        } else{
            self.title = fromError.localizedDescription
            self.body = fromError.localizedRecoverySuggestion
        }
    }
    
    init(statusCode: Int, title: String, body: String) {
        self.statusCode = statusCode
        self.title = title
        self.body = body
    }
}

