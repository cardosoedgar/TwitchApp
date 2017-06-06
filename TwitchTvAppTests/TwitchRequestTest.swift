//
//  TwitchRequest.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 06/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Nimble
import Quick

@testable import TwitchTvApp

class TwitchRequestTest: QuickSpec {
    override func spec() {
        describe("TwitchRequest") {
            
            var twitchRequest: TwitchRequest!
            
            beforeEach {
                twitchRequest = TwitchRequest()
            }
            
            it("should return nil for invalid json") {
                twitchRequest.networkRequest = NetworkRequestMock()
                var response: [JsonObject]? = [JsonObject]()
                
                twitchRequest.getGames(completion: { jsonObject in
                    response = jsonObject
                })
                
                expect(response).toEventually(beNil())
            }
            
            it("should return nil for error conection") {
                twitchRequest.networkRequest = NetworkRequestMock(error: true)
                var response: [JsonObject]? = [JsonObject]()
                
                twitchRequest.getGames(completion: { jsonObject in
                    response = jsonObject
                })
                
                expect(response).toEventually(beNil())
            }
            
            it("should return jsonobject for valid json") {
                let json = Json(json: JsonHelper.readJson())
                twitchRequest.networkRequest = NetworkRequestMock(json: json)
                var response: [JsonObject]? = nil
                
                twitchRequest.getGames(completion: { jsonObject in
                    response = jsonObject
                })
                
                expect(response).toEventuallyNot(beNil())
            }
        }
    }
}
