//
//  NetworkRequest.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation
import Alamofire

enum Result<T> {
    case success(T)
    case error
}

protocol NetworkRequestProtocol {
    func request(
        _ url: URL,
        method: HTTPMethod,
        parameters: [String: Any]?,
        headers: [String: String]?,
        completion: @escaping (Result<Json>) -> Void)
        -> Void
}

class NetworkRequest: NetworkRequestProtocol {
    
    let manager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 10
        return SessionManager(configuration: configuration)
    }()
    
    func request(_ url: URL, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (Result<Json>) -> Void) -> Void {

        manager.request(url,
                        method: method,
                        parameters: parameters,
                        encoding: URLEncoding.default,
                        headers: headers).responseJSON(completionHandler: { (response) in
                            if let value = response.result.value, let result = Json(json: value) {
                                completion(.success(result))
                            } else {
                                completion(.error)
                            }
                        })
    }
}
