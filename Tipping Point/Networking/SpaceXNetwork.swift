//
//  SpaceXNetwork.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

/// A networking layer that makes calls to the SpaceX API.
class SpaceXNetwork {
    /// A shared instance of the network layer.
    static let shared = SpaceXNetwork(session: URLSession(configuration: .default))

    /// A typealias pointing to the networking layer's error enumeration.
    typealias NetworkError = SpaceXNetworkError

    /// A typealias that represents a raw response from the network.
    typealias Response = Result<Data, NetworkError>

    /// A typealias that represents a decoded response from the network.
    typealias DecodedResponse<T: Decodable> = Result<T, NetworkError>

    /// The internal session that will make requests to the API.
    private var session: URLSession

    /// The API's base URL.
    private var baseURL: String = "https://api.spacexdata.com/v3"

    /// An enumeration of the different endpoints that can be called.
    enum Endpoint {
        /// The launches endpoint.
        case launches

        /// The previous launches endpoint.
        case pastLaunches

        /// A generic endpoint that points to anywhere.
        /// - Important: Do not use this unless you know what you're doing!
        case unsafe(String)

        /// The endpoint's path, which can be appended to a base URL.
        var path: String {
            switch self {
            case .pastLaunches: return "/launches/past"
            case .launches: return "/launches"
            case .unsafe(let path): return path
            }
        }
    }

    /// Instantiates a network service.
    /// - Parameter session: The `URLSession` that will be used to make calls internally.
    init(session: URLSession) {
        self.session = session
    }

    private func makeRequest(to endpoint: String, completion: @escaping (Response) -> Void) {
        var requestPath = baseURL + endpoint
        if endpoint.starts(with: "https://") {
            print("WARN: Endpoint is a different URL: \(endpoint)")
            requestPath = endpoint
        }

        guard let url = URL(string: requestPath) else {
            completion(.failure(.badRequest))
            return
        }

        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, resp, err in
            if let error = err {
                completion(.failure(.other(error)))
                return
            }
            if let response = resp as? HTTPURLResponse, !(200 ..< 300).contains(response.statusCode) {
                completion(.failure(.statusNotOk(response.statusCode)))
                return
            }
            guard let data else {
                completion(.failure(.badData))
                return
            }
            completion(.success(data))
        }.resume()
    }

    /// Makes a GET request to an endpoint.
    /// - Parameter endpoint: The endpoint to fetch data from.
    /// - Parameter completion: A completion handler that executes when the request returns.
    func request(endpoint: Endpoint, completion: @escaping (Response) -> Void) {
        makeRequest(to: endpoint.path, completion: completion)
    }

    /// Makes a GET request to an endpoint.
    /// - Parameter endpoint: The endpoint to fetch data from.
    /// - Parameter completion: A completion handler that executes when the request returns.
    func request<T: Decodable>(endpoint: Endpoint, completion: @escaping (DecodedResponse<T>) -> Void) {
        makeRequest(to: endpoint.path) { response in
            switch response {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let decoded = try decoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(.decodeFailure(error)))
                }
            case .failure(let reason):
                completion(.failure(reason))
            }
        }
    }
}
