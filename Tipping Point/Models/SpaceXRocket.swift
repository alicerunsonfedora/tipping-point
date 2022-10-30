//
//  SpaceXRocket.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

/// A rocket represented by the SpaceX API.
struct SpaceXRocket: Decodable {
    /// The rocket's ID.
    let id: String

    /// The rocket's name.
    let name: String

    /// The rocket's type.
    let type: String

    /// An enumeration of the various coding keys for decoding.
    enum CodingKeys: String, CodingKey {
        case id = "rocketId"
        case name = "rocketName"
        case type = "rocketType"
    }
}
