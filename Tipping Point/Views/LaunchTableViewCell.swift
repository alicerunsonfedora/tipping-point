//
//  LaunchTableViewCell.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit

class LaunchTableViewCell: UITableViewCell {
    static let ReuseID = "\(LaunchTableViewCell.self)"
    lazy var name: UILabel = {
        let label = UILabel(text: "Hi there!")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInitialState()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setInitialState() {
        let stack = UIStackView(axis: .vertical, alignment: .leading)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubviews([name])
//        name.bindToSuperView(insets: .zero, useSafeArea: false)
        addSubview(stack)
        stack.bindToSuperView(horizontalInsets: 10, verticalInsets: 8)
    }
}
