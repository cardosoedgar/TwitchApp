//
//  NetworkRequestMock.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 06/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//
import Alamofire

@testable import TwitchTvApp

class NetworkRequestMock: NetworkRequestProtocol {
    
    let json: Json?
    let error: Bool
    
    init(json: Json? = nil, error: Bool = false) {
        self.json = json
        self.error = error
    }
    
    func request(_ url: URL, method: HTTPMethod, parameters: [String : Any]?, headers: [String : String]?, completion: @escaping (TwitchTvApp.Result<Json>) -> Void) {
        if error {
            completion(.error)
            return
        }
        
        guard let json = self.json else {
            completion(.error)
            return
        }
        
        completion(.success(json))
    }
}
