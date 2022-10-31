//
//  SpaceXNetworkServiceDelegate.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/31/22.
//

import Foundation

/// A protocol that represents a networking interface with the SpaceX API.
protocol SpaceXNetworkServiceDelegate: AnyObject {
    /// Makes a request to the server.
    /// - Parameter request: The URL request that will be performed.
    /// - Parameter completion: The completion handler that executes when the URL request completes.
    func get(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: SpaceXNetworkServiceDelegate {
    func get(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        dataTask(with: request, completionHandler: completion).resume()
    }
}
