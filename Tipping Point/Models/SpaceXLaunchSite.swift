//
//  SpaceXLaunchSite.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

struct SpaceXLaunchSite: Decodable {
    let id: String
    let shortName: String
    let longName: String

    enum CodingKeys: String, CodingKey {
        case id = "siteId"
        case shortName = "siteName"
        case longName = "siteNameLong"
    }
}
