//
//  LaunchDetailViewModel.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/30/22.
//

import Foundation

class LaunchDetailViewModel {
    typealias UpdateHandlerType = () -> Void
    typealias Row = (String, String)
    private var sections = [[Row]]() {
        didSet { updateHandler?() }
    }

    private var launch: SpaceXLaunch
    private var updateHandler: UpdateHandlerType?

    var sectionTitles = [String]()

    init(with launch: SpaceXLaunch) {
        self.launch = launch
    }

    func reload(with launch: SpaceXLaunch) {
        self.launch = launch
        fetch()
    }

    func numberOfSections() -> Int {
        sections.count
    }

    func numberOfRows(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].count
    }

    func section(at index: Int) -> [Row] {
        guard index < sections.count else { return [] }
        return sections[index]
    }

    func sectionTitle(at index: Int) -> String? {
        guard index < sectionTitles.count else { return nil }
        return sectionTitles[index]
    }

    func footer(at index: Int) -> String? {
        guard index < sections.count else { return nil }
        guard let missionIdx = sectionTitles.firstIndex(where: { $0 == "Mission Details" }) else { return nil }
        return (index == missionIdx) ? launch.description : nil
    }

    private func createBasicSection() -> [Row] {
        sectionTitles.append("Basic Information")
        var basicInfo = [
            ("Flight Number", "\(launch.flightNumber)"),
            ("Launch Site", launch.launchSite.longName)
        ]
        if let launchDate = launch.launchDate.formatDateFromISO8601(style: .full, time: .short) {
            basicInfo.append(("Launch Date", launchDate))
        }
        if let launchWindow = launch.launchWindow {
            basicInfo.append(("Launch Window", "\(launchWindow)"))
        }
        if launch.tentative {
            basicInfo.append(("Tentative Max Precision", launch.tentativeMaxPrecision))
        }
        return basicInfo
    }

    private func createMissionSection() -> [Row] {
        sectionTitles.append("Mission Details")
        var missionProperties = [("Mission", launch.missionName)]
        if !launch.missionId.isEmpty {
            missionProperties.append(("Mission IDs", launch.missionId.joined(separator: ", ")))
        }
        return missionProperties
    }

    private func createRocketSection() -> [Row] {
        sectionTitles.append("Rocket")
        var rocketInfo = [
            ("Rocket Name", launch.rocket.name),
            ("Rocket Type", launch.rocket.type)
        ]
        if !launch.ships.isEmpty {
            rocketInfo.append(("Ships", launch.ships.joined(separator: ", ")))
        }
        return rocketInfo
    }
}

extension LaunchDetailViewModel: ViewModel {
    func bind(handler: @escaping () -> Void) {
        updateHandler = handler
    }

    func fetch() {
        sections = [
            createBasicSection(),
            createMissionSection(),
            createRocketSection()
        ]
    }
}
