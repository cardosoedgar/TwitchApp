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
    
    let total: Int
    let top: [Game]
    
    init?(json: JsonObject?) {
        self.total = json?["_total"] as? Int ?? 0
        self.top = [Game]()
    }
}
