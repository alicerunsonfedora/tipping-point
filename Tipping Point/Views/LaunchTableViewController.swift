//
//  LaunchTableViewController.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit

class LaunchTableViewController: UITableViewController {
    var viewModel: LaunchesViewModel?
    weak var launchSelectionDelegate: LaunchSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Launches"
        tableView.dataSource = self
        tableView.register(LaunchTableViewCell.self)

        let viewModel = LaunchesViewModel(with: .shared)
        self.viewModel = viewModel
        viewModel.bind { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        viewModel.fetch()
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel?.numberOfLaunches() ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = self.viewModel,
              let cell = tableView.dequeueReusableCell(LaunchTableViewCell.self, for: indexPath) else {
            return LaunchTableViewCell()
        }
        cell.configure(with: viewModel, at: indexPath.row)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let launch = viewModel?.launch(at: indexPath.row) else { return }
        launchSelectionDelegate?.launchSelected(launch)
        if let detailVC = launchSelectionDelegate as? LaunchDetailViewController {
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
    }
}
