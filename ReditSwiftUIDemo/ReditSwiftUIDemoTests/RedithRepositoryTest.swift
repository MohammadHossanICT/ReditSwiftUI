//
//  RedithRepositoryTest.swift
//  ReditSwiftUIDemoTests
//
//  Created by M A Hossan on 17/04/2023.
//

import XCTest
@testable import ReditSwiftUIDemo

final class RedithRepositoryTest: XCTestCase {

    var fakeNetworkManager: FakeNetworkManager!
    var redithRepository: RedithRepository!

    override func setUpWithError() throws {
        fakeNetworkManager = FakeNetworkManager()
        redithRepository = RedithRepositoryImplementation (networkManager: fakeNetworkManager)
    }
    override func tearDownWithError() throws {
        redithRepository = nil
    }

    // when passes employee list array will return with some data
    func test_when_get_Childaren_list_success() async {
        let lists = try? await redithRepository.getList(for: URL(string:"reddit_response")!)
        XCTAssertNotNil(lists)
        XCTAssertEqual(lists?.data.children.count, 25)
        XCTAssertEqual(lists?.data.children.first?.data.title,
                       "Belgium approves four-day week and gives employees the right to ignore their bosses after work")
    }

    // when fails, employee list will be nil
    func test_when_get_Children_list_fails() async throws {
        let lists = try? await redithRepository.getList(for: URL(string:"falie_response")!)
        XCTAssertNil(lists)

    }

}
