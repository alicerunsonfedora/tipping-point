//
//  SpaceXLaunch.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

struct SpaceXLaunch: Decodable {
    let flightNumber: Int
    let missionName: String
    let missionId: [String]
    let launchYear: String
    let launchDate: String
    let tentative: Bool
    let tentativeMaxPrecision: String
    let launchWindow: Int?
    let rocket: SpaceXRocket
    let ships: [String]
    let launchSite: SpaceXLaunchSite

    enum CodingKeys: String, CodingKey {
        case flightNumber
        case missionName
        case missionId
        case launchYear
        case launchDate = "launchDateUtc"
        case tentative = "isTentative"
        case tentativeMaxPrecision
        case launchWindow
        case rocket
        case ships
        case launchSite
    }
}
