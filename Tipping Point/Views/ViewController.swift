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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        delegate = self
        let primary = UINavigationController(rootViewController: DummyViewController())
        let detail = UINavigationController(rootViewController: DummyViewController())

        viewControllers = [primary, detail]

        SpaceXNetwork.shared.request(endpoint: .launches) { (result: SpaceXNetwork.DecodedResponse<[SpaceXLaunch]>) in
            print(result)
        }
    }
}

extension ViewController: UISplitViewControllerDelegate {
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
    ) -> Bool {
        return true
    }
}
