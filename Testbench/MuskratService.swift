//
//  MuskratService.swift
//  Testbench
//
//  Created by Marquis Kurt on 10/31/22.
//

import Foundation
@testable import Tipping_Point

class MuskratService: SpaceXNetworkServiceDelegate {
    enum Touchpoint: String {
        case launchData = "https://api.spacexdata.com/v3/launches/past"
        case badAccess = "https://err.hex.code/chel/bad_access"
        case badData = "https://err.hex.code/chel/nil"
        case badDecode = "https://aperturescience.com/garbage"
    }

    private func httpResponse(from url: URL, code: Int = 200) -> HTTPURLResponse? {
        HTTPURLResponse(url: url, statusCode: code, httpVersion: "1.1", headerFields: nil)
    }

    func get(with request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = request.url else {
            completion(nil, nil, SpaceXNetworkError.badRequest)
            return
        }
        switch url.absoluteString {
        case Touchpoint.launchData.rawValue:
            guard let path = Bundle(for: Self.self).path(forResource: "Launches", ofType: "json") else {
                completion(nil, nil, MuskratServiceError.mockDataMissing)
                return
            }
            let url = URL(fileURLWithPath: path)
            let data = try? Data(contentsOf: url)
            completion(data, httpResponse(from: url), nil)
        case Touchpoint.badAccess.rawValue:
            completion(nil, httpResponse(from: url, code: 401), nil)
        case Touchpoint.badData.rawValue:
            completion(nil, httpResponse(from: url), nil)
        case Touchpoint.badDecode.rawValue:
            let data = "You don't need to test the gargabe. It's garbage.".data(using: .utf8)
            completion(data, httpResponse(from: url), nil)
        default:
            completion(nil, nil, MuskratServiceError.unknownEndpoint)
        }
    }
}

enum MuskratServiceError: Error {
    case mockDataMissing
    case unknownEndpoint
}

extension MuskratServiceError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .mockDataMissing: return "The mock data file is missing."
        case .unknownEndpoint: return "The endpoint isn't known to the muskrat."
        }
    }
}
