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
    let coreDataStack = CoreDataStackManager()
    
    let url: URL = URL(string: "https://api.twitch.tv/kraken/games/top?limit=50&client_id=dl2l5499288pnoy3sefchp6mlebxmc")!
    
    func getGames(completion: @escaping ([JsonObject]?) -> Void) {
        networkRequest.request(url, method: .get, parameters: nil, headers: nil) { result in
            switch result {
            case .success(.object (let response)):
                guard let gamesJson = response["top"] as? [JsonObject] else {
                    completion(nil)
                    return
                }
                
                completion(gamesJson)
            default:
                completion(nil)
            }
        }
    }
}
