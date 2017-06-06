//
//  Game.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation
import CoreData

class Game: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var image: String
    @NSManaged var viewers: Int
    @NSManaged var channels: Int
    
    class func load(jsonObject: JsonObject, context: NSManagedObjectContext) -> Game? {
        let gameEntity = NSEntityDescription.entity(forEntityName: "Game", in: context)
        let game = Game(entity: gameEntity!, insertInto: context)
        
        guard let gameJson = jsonObject["game"] as? JsonObject,
            let name = gameJson["name"] as? String,
            let imageJson = gameJson["box"] as? JsonObject,
            let image = imageJson["large"] as? String,
            let viewers = jsonObject["viewers"] as? Int,
            let channels = jsonObject["channels"] as? Int else {
                return nil
        }
        
        game.name = name
        game.image = image
        game.viewers = viewers
        game.channels = channels
        
        return game
    }
    
    class func loadArray(jsonArray: [JsonObject], context: NSManagedObjectContext) -> [Game] {
        var games = [Game]()
        for gameJson in jsonArray {
            if let game = Game.load(jsonObject: gameJson, context: context) {
                games.append(game)
            }
        }
        
        return games
    }
}
