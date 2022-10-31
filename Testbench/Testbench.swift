//
//  Testbench.swift
//  Testbench
//
//  Created by Marquis Kurt on 10/31/22.
//

@testable import Tipping_Point
import XCTest

/// A test case for the networking layer.
class ServiceLayerTests: XCTestCase {
    /// A typealias for the response type the service may receive.
    typealias DecodedResponse = SpaceXNetwork.DecodedResponse<[SpaceXLaunch]>

    /// The service that will be tested.
    var service: SpaceXNetwork?

    override func setUpWithError() throws {
        service = SpaceXNetwork(session: MuskratService())
    }

    override func tearDownWithError() throws {
        service = nil
    }

    /// Returns an endpoint that matches a given error.
    private func getErrorEndpoint(err: SpaceXNetworkError) -> SpaceXNetwork.Endpoint {
        switch err {
        case .statusNotOk: return .unsafe(MuskratService.Touchpoint.badAccess.rawValue)
        case .badData: return .unsafe(MuskratService.Touchpoint.badData.rawValue)
        case .decodeFailure: return .unsafe(MuskratService.Touchpoint.badDecode.rawValue)
        default: return .unsafe("")
        }
    }

    /// Test that the service can fetch and decode data successfully.
    func testServiceFetchesData() throws {
        service?.request(endpoint: .pastLaunches, completion: { (result: DecodedResponse) in
            switch result {
            case .success(let data):
                XCTAssertFalse(data.isEmpty)
                XCTAssertEqual(data.first?.flightNumber, 1)
            case .failure(let error):
                XCTFail("Received error: \(error.localizedDescription)")
            }
        })
    }

    /// Test that the service fails when given a bad request, such as an empty endpoint.
    func testServiceFailsOnBadRequest() throws {
        service?.request(endpoint: getErrorEndpoint(err: .badRequest), completion: { (result: DecodedResponse) in
            switch result {
            case .success(let data):
                XCTFail("Success case shouldn't be reached: \(data)")
            case .failure(let error):
                switch error {
                case .badRequest:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Received other error: \(error.localizedDescription)")
                }
            }
        })
    }

    /// Test that the service fails when receiving bad data.
    func testServiceFailsOnBadData() throws {
        service?.request(endpoint: getErrorEndpoint(err: .badData), completion: { (result: DecodedResponse) in
            switch result {
            case .success(let data):
                XCTFail("Success case shouldn't be reached on unauthorized endpoints: \(data)")
            case .failure(let error):
                switch error {
                case .badData:
                    XCTAssertTrue(true)
                default:
                    XCTFail("Received other error: \(error.localizedDescription)")
                }
            }
        })
    }

    /// Test that the service fails if the status code was not OK.
    func testServiceFailsWithNonOKCodes() throws {
        service?.request(endpoint: getErrorEndpoint(err: .statusNotOk(401)), completion: { (result: DecodedResponse) in
            switch result {
            case .success(let data):
                XCTFail("Success case shouldn't be reached on unauthorized endpoints: \(data)")
            case .failure(let error):
                switch error {
                case .statusNotOk(let code):
                    XCTAssertEqual(code, 401)
                default:
                    XCTFail("Received non-auth error: \(error.localizedDescription)")
                }
            }
        })
    }

    /// Test that the services fails to decode an object.
    func testServiceFailsOnDecodeError() throws {
        let context = DecodingError.Context(codingPath: [], debugDescription: "")
        service?.request(
            endpoint: getErrorEndpoint(
                err: .decodeFailure(DecodingError.dataCorrupted(context))
            ),
            completion: { (result: DecodedResponse) in
                switch result {
                case .success(let data):
                    XCTFail("Success case shouldn't be reached on unauthorized endpoints: \(data)")
                case .failure(let error):
                    switch error {
                    case .decodeFailure(let error):
                        XCTAssertNotNil(error)
                    default:
                        XCTFail("Received non-decoding error: \(error.localizedDescription)")
                    }
                }
            }
        )
    }
}
