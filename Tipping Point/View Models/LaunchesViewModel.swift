//
//  LaunchesViewModel.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

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
                case .failure(let error):
                    print("Err: \(error)")
                }
            }
    }
}
