//
//  LaunchTableViewCell.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    var launch: SpaceXLaunch?
    var launchIdx: Int?

    lazy var badge: UIImageView = {
        let image = UIImageView(image: .init(systemName: "airplane.departure"))
        image.contentMode = .scaleAspectFit
        return image
    }()

    lazy var name: UILabel = {
        let label = UILabel(text: "A Great Mission")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()

    lazy var rocketSite: UILabel = {
        let label = UILabel(text: "Rocket 0 | Space")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        return label
    }()

    lazy var date: UILabel = {
        let label = UILabel(text: "Unknown date")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .tertiaryLabel
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialState()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setInitialState() {
        let stack = UIStackView(axis: .horizontal, alignment: .center, spacing: 10)
        stack.translatesAutoresizingMaskIntoConstraints = false
        badge.constrainToSize(width: 64, height: 64)

        let textStack = UIStackView(axis: .vertical, alignment: .leading)
        textStack.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubviews([name, rocketSite, date])
        stack.addArrangedSubviews([badge, textStack])
        addSubview(stack)
        stack.bindToSuperView(horizontalInsets: 10, verticalInsets: 8)
    }

    func configure(with viewModel: LaunchesViewModel, at index: Int) {
        launch = viewModel.launch(at: index)
        launchIdx = index
        if let launch {
            name.text = launch.missionName
            rocketSite.text = "\(launch.rocket.name) | \(launch.launchSite.shortName)"
            if let realDate = launch.launchDate.formatDateFromISO8601() {
                date.text = realDate
            }

            viewModel.missionBadge(at: index) { [weak self] image in
                guard (self?.launchIdx ?? -1) == index else { return }
                DispatchQueue.main.async {
                    if let image {
                        self?.badge.image = image
                    }
                }
            }
        }
    }
}
