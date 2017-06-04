//
//  Response.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation

typealias JsonObject = [String: Any]

class Response {
    
    let games: [Game]
    
    init?(json: JsonObject) {
        guard let gamesJson = json["top"] as? [JsonObject] else {
            return nil
        }
        
        var games = [Game]()
        for gameJson in gamesJson {
            if let game = Game(json: gameJson) {
                games.append(game)
            }
        }
        
        self.games = games
    }
}
