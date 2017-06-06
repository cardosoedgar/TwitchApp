//
//  GameTests.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 05/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Nimble
import Quick

@testable import TwitchTvApp

extension Game {
    static func validJson() -> JsonObject {
        return [
            "game": [
                "name": "Game Name",
                "box": [
                    "large": "image_url"
                ]
            ],
            "channels": 12345,
            "viewers": 54321
        ]
    }
}

class GameTests: QuickSpec {
    override func spec() {
        describe("Game") {

            let mockContext = CoreDataStackManager.mockManagedObjectContext()
            var json: JsonObject!
            
            beforeEach {
                json = Game.validJson()
            }
            
            it("should parse game json") {
                let game = Game.load(jsonObject: json, context: mockContext)
                
                expect(game?.name) == "Game Name"
                expect(game?.image) == "image_url"
                expect(game?.channels) == 12345
                expect(game?.viewers) == 54321
            }
            
            it("should not parse for nil property") {
                json.removeValue(forKey: "game")
                
                let game = Game.load(jsonObject: json, context: mockContext)
                
                expect(game).to(beNil())
            }
            
            it("should parse an array of games") {
                let array: [JsonObject] = [json, json, json]
                
                let games = Game.loadArray(jsonArray: array, context: mockContext)
                
                expect(games.count) == 3
            }
        }
    }
}
