//
//  TwitchRequest.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation

class TwitchRequest {
    
    let networkRequest = NetworkRequest()
    
    let url: URL = URL(string: "https://api.twitch.tv/kraken/games/top?client_id=dl2l5499288pnoy3sefchp6mlebxmc&api_version=5")!
    
    func getGames(completion: @escaping (Response?) -> Void) {
        networkRequest.request(url, method: .get, parameters: nil, headers: nil) { result in
            switch result {
            case .success(.object (let response)):
                completion(Response(json: response))
            default:
                completion(nil)
            }
        }
    }
}
