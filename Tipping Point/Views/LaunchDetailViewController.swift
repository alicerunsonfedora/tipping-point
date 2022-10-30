//
//  LaunchDetailViewController.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import UIKit
import UIToolbox

class LaunchDetailViewController: UITableViewController {
    var viewModel: LaunchDetailViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setInitialState()
    }

    func setInitialState() {
        tableView.register(BasicTextTableViewCell.self)
    }

    func updateState() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func numberOfSections(in _: UITableView) -> Int {
        viewModel?.numberOfSections() ?? 0
    }

    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.numberOfRows(in: section) ?? 0
    }

    override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel?.sectionTitle(at: section)
    }

    override func tableView(_: UITableView, titleForFooterInSection section: Int) -> String? {
        viewModel?.footer(at: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(BasicTextTableViewCell.self, for: indexPath) else {
            return BasicTextTableViewCell()
        }

        if let cellData = viewModel?.section(at: indexPath.section) {
            guard indexPath.row < cellData.count else { return cell }
            let (propTitle, propDetail) = cellData[indexPath.row]
            cell.configure(title: propTitle, with: propDetail)
        }

        return cell
    }
}

extension LaunchDetailViewController: LaunchSelectionDelegate {
    func launchSelected(_ launch: SpaceXLaunch) {
        title = launch.missionName
        guard let currentVM = viewModel else {
            let viewModel = LaunchDetailViewModel(with: launch)
            viewModel.bind { [weak self] in
                self?.updateState()
            }
            self.viewModel = viewModel
            viewModel.fetch()
            return
        }
        currentVM.reload(with: launch)
    }
}
