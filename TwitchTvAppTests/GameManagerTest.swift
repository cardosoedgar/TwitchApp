//
//  GameManagerTest.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 06/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Nimble
import Quick

@testable import TwitchTvApp

class GameManagerTest: QuickSpec {
    override func spec() {
        describe("GameManager") {
            
            var gameManager: GameManager!
            var coreDataStackMock: CoreDataStackManager!
            var twitchRequest: TwitchRequest!
            
            beforeEach {
                gameManager = GameManager()
                coreDataStackMock = CoreDataStackManager()
                coreDataStackMock.context = CoreDataStackManager.mockManagedObjectContext()
                twitchRequest = TwitchRequest()
                twitchRequest.networkRequest = NetworkRequestMock()
                
                gameManager.coreDataStack = coreDataStackMock
                gameManager.twitchRequest = twitchRequest
            }
            
            it("should load games") {
                let json = Json(json: JsonHelper.readJson(name: "valid"))
                twitchRequest.networkRequest = NetworkRequestMock(json: json)
                var success = false
                
                gameManager.loadGames { result in
                   success = result
                }
                
                expect(success).toEventually(beTrue())
            }
            
            it("should return false when an error occur on loadGames method") {
                twitchRequest.networkRequest = NetworkRequestMock(error: true)
                var success = true
                
                gameManager.loadGames { result in
                    success = result
                }
                
                expect(success).toEventually(beFalse())
            }
            
            it("should give Game at Index") {
                let json = Json(json: JsonHelper.readJson(name: "valid"))
                twitchRequest.networkRequest = NetworkRequestMock(json: json)
                var game: Game? = nil
                
                gameManager.loadGames{ success in
                   game = gameManager.gameAt(index: 0)
                }
                
                expect(game).toEventuallyNot(beNil())
            }
            
            it("should fetch games from core data") {
                let json = Json(json: JsonHelper.readJson(name: "valid"))
                twitchRequest.networkRequest = NetworkRequestMock(json: json)
                var games: [Game]? = nil
                
                gameManager.loadGames{ success in
                    games = gameManager.fetchGames()
                }
                
                expect(games).toEventuallyNot(beNil())
            }
        }
    }
}
