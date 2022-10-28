//
//  LaunchesViewModel.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation
import UIKit

protocol ViewModel {
    func bind(handler: @escaping () -> Void)
    func fetch()
}

class LaunchesViewModel {
    typealias UpdateHandlerType = () -> Void
    private var launches = [SpaceXLaunch]() {
        didSet { updateHandler?() }
    }

    private var updateHandler: UpdateHandlerType?
    private var network: SpaceXNetwork

    init(with network: SpaceXNetwork) {
        self.network = network
    }

    func numberOfLaunches() -> Int {
        launches.count
    }

    func launch(at index: Int) -> SpaceXLaunch? {
        guard index < launches.count else { return nil }
        return launches[index]
    }

    func missionBadge(at index: Int, completion: @escaping (UIImage?) -> Void) {
        guard let launch = launch(at: index), let patch = launch.links.missionPatchSmall else {
            completion(nil)
            return
        }
        network.request(endpoint: .unsafe(patch)) { result in
            switch result {
            case .success(let data):
                completion(UIImage(data: data))
            case .failure(let error):
                print("Err: \(error)")
                completion(nil)
            }
        }
    }

    private func reorderLaunches() {
        launches.sort { first, second in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
            if let firstDate = formatter.date(from: first.launchDate),
               let secondDate = formatter.date(from: second.launchDate) {
                return firstDate.compare(secondDate) == .orderedDescending
            } else {
                return false
            }
        }
    }
}

extension LaunchesViewModel: ViewModel {
    func bind(handler: @escaping () -> Void) {
        updateHandler = handler
    }

    func fetch() {
        network
            .request(endpoint: .pastLaunches) { [weak self] (result: SpaceXNetwork.DecodedResponse<[SpaceXLaunch]>) in
                switch result {
                case .success(let launches):
                    self?.launches.append(contentsOf: launches)
                    self?.reorderLaunches()
                case .failure(let error):
                    print("Err: \(error)")
                }
            }
    }
}
