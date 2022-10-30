//
//  SpaceXLinkDirectory.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

/// A SpaceX link directory represnted by the SpaceX API.
struct SpaceXLinkDirectory: Decodable {
    /// The link to the mission's patch image.
    let missionPatch: String?

    /// The link to a preview of the mission's patch image.
    let missionPatchSmall: String?
}
