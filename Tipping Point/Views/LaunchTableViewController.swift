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
        tableView.register(LaunchTableViewCell.self, forCellReuseIdentifier: LaunchTableViewCell.ReuseID)

        let viewModel = LaunchesViewModel(with: .shared)
        self.viewModel = viewModel
        viewModel.bind { [weak self] in
            print("FIRE!")
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
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: LaunchTableViewCell.ReuseID, for: indexPath) as? LaunchTableViewCell
        else {
            return LaunchTableViewCell()
        }
        cell.name.text = "Whoosh"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let launch = viewModel?.launch(at: indexPath.row) else { return }
        launchSelectionDelegate?.launchSelected(launch)
        if let detailVC = launchSelectionDelegate as? DummyViewController {
            splitViewController?.showDetailViewController(detailVC, sender: nil)
        }
    }
}
