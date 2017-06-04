//
//  Game.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation

class Game {
    
    let name: String
    let image: URL
    let viewers: Int
    let channels: Int
    
    init?(json: JsonObject) {
        guard let game = json["game"] as? JsonObject,
            let name = game["name"] as? String,
            let imageJson = game["box"] as? JsonObject,
            let image = imageJson["large"] as? String,
            let viewers = json["viewers"] as? Int,
            let channels = json["channels"] as? Int else {
                return nil
        }
        
        self.name = name
        self.image = URL(string: image)!
        self.viewers = viewers
        self.channels = channels
    }
}
