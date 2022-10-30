//
//  LaunchDetailViewController.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit
import UIToolbox

class LaunchDetailViewController: UIViewController {
    var launch: SpaceXLaunch?

    lazy var missionName: UILabel = {
        let label = UILabel(text: "Select a Launch")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()

    lazy var rocketSite: UILabel = {
        let label = UILabel(text: "Rocket | Site Name")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()

    lazy var missionPatch: UIImageView = {
        let image = UIImageView(image: .init(systemName: "airplane.departure"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setInitialState()
    }

    func setInitialState() {
        let textStack = UIStackView(axis: .vertical, alignment: .leading)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubviews([missionName, rocketSite])

        let titleStack = UIStackView(axis: .horizontal, alignment: .center, spacing: 10)
        titleStack.translatesAutoresizingMaskIntoConstraints = false
        titleStack.addArrangedSubviews([missionPatch, textStack])
        missionPatch.constrainToSize(square: 96)

        let mainStack = UIStackView(axis: .vertical, alignment: .center, spacing: 10)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.addArrangedSubviews([titleStack])

        let scrollView = UIScrollView(frame: mainStack.bounds)
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.bindToSuperView()

        scrollView.addSubview(mainStack)
        mainStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        mainStack.bindToSuperView()
    }

    func updateState() {
        if let launch = launch {
            missionName.text = launch.missionName
            rocketSite.text = "\(launch.rocket.name) | \(launch.launchSite.longName)"
        }
    }
}

extension LaunchDetailViewController: LaunchSelectionDelegate {
    func launchSelected(_ launch: SpaceXLaunch) {
        self.launch = launch
        updateState()
    }
}
