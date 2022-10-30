//
//  SpaceXLaunchSite.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

/// A launch site represented by the SpaceX API.
struct SpaceXLaunchSite: Decodable {
    /// The launch site's ID.
    let id: String

    /// An abbreviated form of the site's name.
    let shortName: String

    /// The site's full name.
    let longName: String

    /// An enumeration of the various coding keys for decoding.
    enum CodingKeys: String, CodingKey {
        case id = "siteId"
        case shortName = "siteName"
        case longName = "siteNameLong"
    }
}
