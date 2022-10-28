//
//  LaunchDetailViewController.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation
import UIKit

class LaunchDetailViewController: UIViewController {
    var launch: SpaceXLaunch?

    lazy var label: UILabel = {
        let label = UILabel(text: "Lorem ipsum dolor")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func updateState() {
        label.text = launch?.missionName ?? "A Great Mission"
    }
}

extension LaunchDetailViewController: LaunchSelectionDelegate {
    func launchSelected(_ launch: SpaceXLaunch) {
        self.launch = launch
        updateState()
    }
}
