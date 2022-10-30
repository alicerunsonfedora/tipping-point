//
//  LaunchSelectionDelegate.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation
import UIKit

/// A delegate used to communicate between two views for launches in a split view controller.
protocol LaunchSelectionDelegate: AnyObject {
    /// A method called when any view selects a launch to be updated into the detail controller.
    func launchSelected(_ launch: SpaceXLaunch)
}
