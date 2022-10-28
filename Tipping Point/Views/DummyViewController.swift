//
//  DummyViewController.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit
import UIToolbox

/// A dumm view controller used to test certain navigation components.
class DummyViewController: UIViewController {
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
}

extension DummyViewController: LaunchSelectionDelegate {
    func launchSelected(_ launch: SpaceXLaunch) {
        label.text = "\(launch.flightNumber)"
    }
}
