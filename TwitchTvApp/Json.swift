//
//  Json.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import Foundation

enum Json {
    case object(_: JsonObject)
    case array(_: [JsonObject])
    
    init?(json: Any) {
        if let object = json as? JsonObject {
            self = .object(object)
            return
        }
        
        if let array = json as? [JsonObject] {
            self = .array(array)
            return
        }
        
        return nil
    }
}
