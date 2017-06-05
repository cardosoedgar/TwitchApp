//
//  Response.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation
import CoreData

typealias JsonObject = [String: Any]

class Response {
    
    let cdStack = CoreDataStackManager()
    let games: [Game]
    
    init?(json: JsonObject) {
        guard let gamesJson = json["top"] as? [JsonObject] else {
            return nil
        }
        
        var games = [Game]()
        for gameJson in gamesJson {
            if let game = Game.load(jsonObject: gameJson, context: cdStack.context) {
                games.append(game)
            }
        }
        
        self.games = games
        self.deleteGames()
        cdStack.saveContext()
    }
    
    func deleteGames() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try cdStack.psc.execute(deleteRequest, with: cdStack.context)
            cdStack.saveContext()
        } catch {
            
        }
    }
    
    init() {
        let gamesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        
        do {
            guard let result = try cdStack.context.fetch(gamesFetch) as? [Game] else {
                self.games = [Game]()
                return
            }
            
            self.games = result
        } catch {
            self.games = [Game]()
        }
    }
}
