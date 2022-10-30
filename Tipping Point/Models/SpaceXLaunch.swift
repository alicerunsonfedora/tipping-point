//
//  SpaceXLaunch.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

/// A launch represented by the SpaceX API.
struct SpaceXLaunch: Decodable {
    /// The launch's flight number.
    let flightNumber: Int

    /// The name of the mission the launch corresponds to.
    let missionName: String

    /// An array of mission IDs associated with this launch.
    let missionId: [String]

    /// An ISO-8061 string that represents when the launch occurred.
    let launchDate: String

    /// Whether the launch is tentative.
    let tentative: Bool

    /// The launch's tentative max precision.
    let tentativeMaxPrecision: String

    /// The launch window.
    let launchWindow: Int?

    /// The rocket used in the launch.
    let rocket: SpaceXRocket

    /// An array of ships used in the launch.
    let ships: [String]

    /// The site where the launch occurred.
    let launchSite: SpaceXLaunchSite

    /// A directory of links.
    let links: SpaceXLinkDirectory

    /// An enumeration of the various coding keys for decoding.
    enum CodingKeys: String, CodingKey {
        case flightNumber
        case missionName
        case missionId
        case launchDate = "launchDateUtc"
        case tentative = "isTentative"
        case tentativeMaxPrecision
        case launchWindow
        case rocket
        case ships
        case launchSite
        case links
    }
}
