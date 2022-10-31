//
//  SpaceXNetworkError.swift
//  Tipping Point
//
//  Created by Marquis Kurt on 10/28/22.
//

import Foundation

/// An enumeration for the various errors the SpaceX networking layer may throw.
enum SpaceXNetworkError: Error {
    /// The request was malformed.
    case badRequest

    /// The status code of the response was not OK (~200).
    case statusNotOk(Int)

    /// The response return bad data.
    case badData

    /// An error occurred when decoding the data.
    case decodeFailure(Error)

    /// A catch-all error case.
    case other(Error)
}

extension SpaceXNetworkError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .badRequest: return "The request was malformed or bad."
        case .statusNotOk(let code): return "Request received non-OK status code: \(code)"
        case .badData: return "The request received bad data."
        case .decodeFailure(let err): return "Decoding failed: \(err.localizedDescription)"
        case .other(let err): return "An unknown error occurred: \(err.localizedDescription)"
        }
    }
}
