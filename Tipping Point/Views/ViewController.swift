//
//  ViewController.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit
import UIToolbox

/// The primary view controller that displays the split view controller.
class ViewController: UISplitViewController {
    var viewModel: LaunchesViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpSplitViewController()
    }

    private func setUpSplitViewController() {
        delegate = self
        let primary = LaunchTableViewController(style: .insetGrouped)
        let detail = LaunchDetailViewController(style: .insetGrouped)
        primary.launchSelectionDelegate = detail
        let primNavController = UINavigationController(rootViewController: primary)
        primNavController.navigationBar.prefersLargeTitles = true
        detail.navigationController?.navigationBar.prefersLargeTitles = true
        viewControllers = [primNavController, UINavigationController(rootViewController: detail)]
    }
}

extension ViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _: UISplitViewController,
        topColumnForCollapsingToProposedTopColumn _: UISplitViewController.Column
    ) -> UISplitViewController.Column {
        .primary
    }

    public func splitViewController(
        _: UISplitViewController,
        collapseSecondary _: UIViewController,
        onto _: UIViewController
    ) -> Bool {
        true
    }
}
