//
//  GameManager.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 05/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation
import CoreData

class GameManager {
    
    var coreDataStack = CoreDataStackManager()
    var twitchRequest = TwitchRequest()
    
    private var games = [Game]()
    
    func loadGames(completion: @escaping (Bool) -> Void) {
        twitchRequest.getGames { jsonObject in
            guard let json = jsonObject else {
                if self.games.isEmpty {
                    self.games = self.fetchGames()
                }
                
                completion(false)
                return
            }
            
            self.deleteGames()
            self.games = Game.loadArray(jsonArray: json, context: self.coreDataStack.context)
            self.coreDataStack.saveContext()
            completion(true)
        }
    }
    
    func gameAt(index: Int) -> Game? {
        if index >= 0 && index < games.count {
            return games[index]
        }
        
        return nil
    }
    
    func gamesCount() -> Int {
        return games.count
    }
    
    func fetchGames() -> [Game] {
        let gamesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        
        do {
            guard let result = try coreDataStack.context.fetch(gamesFetch) as? [Game] else {
                return [Game]()
            }
            
            return result
        } catch {
            return [Game]()
        }
    }
    
    func deleteGames() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Game")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try coreDataStack.psc.execute(deleteRequest, with: coreDataStack.context)
            coreDataStack.saveContext()
        } catch { }
    }
}
