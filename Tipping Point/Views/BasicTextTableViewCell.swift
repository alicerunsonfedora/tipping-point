//
//  BasicTextTableViewCell.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/30/22.
//

import UIKit

class BasicTextTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel(text: "Lorem Ipsum")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    lazy var detailLabel: UILabel = {
        let label = UILabel(text: "Dolor Si Amet")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        label.numberOfLines = 1
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
        let stack = UIStackView(axis: .horizontal, alignment: .firstBaseline)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubviews([titleLabel, detailLabel])
        addSubview(stack)
        stack.bindToSuperView(horizontalInsets: 24, verticalInsets: 12, useSafeArea: false)
        titleLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
    }

    func configure(title: String, with detail: String) {
        titleLabel.text = title
        detailLabel.text = detail
    }
}
