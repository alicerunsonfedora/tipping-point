//
//  SpaceXRocket.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

struct SpaceXRocket: Decodable {
    let id: String
    let name: String
    let type: String

    enum CodingKeys: String, CodingKey {
        case id = "rocketId"
        case name = "rocketName"
        case type = "rocketType"
    }
}
