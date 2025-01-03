//
//  TymeXAssignmentTests.swift
//  TymeXAssignmentTests
//
//  Created by Son Hoang Duc on 31/12/24.
//

import XCTest
@testable import TymeXAssignment

final class UserViewModelTests: XCTestCase {
    var viewModel: UserViewModel!
    var mockServices: MockServiceManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockServices = MockServiceManager()
        viewModel = UserViewModel(services: mockServices)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        try? super.tearDownWithError()
        viewModel = nil
        mockServices = nil
    }
    
    func testFetchInitUsers_Success() async throws {
        let testUsers = [
            User(login: "user01", avatarUrl: "url1", url: "url1"),
            User(login: "user02", avatarUrl: "url2", url: "url2")
        ]
        
        mockServices.user = testUsers
        
        await viewModel.fetchInitUsers()
        
        // Add delay 0.1s to wait for async state update
        try await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertEqual(viewModel.user.count, 2)
        XCTAssertEqual(viewModel.user[0].login, "user01")
        XCTAssertEqual(viewModel.user[1].login, "user02")
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchUsers_Fail() async throws {
        struct TestError: Error {}
        mockServices.error = TestError()
        
        await viewModel.fetchInitUsers()
        
        // Add delay 0.1s to wait for async state update
        try await Task.sleep(nanoseconds: 100_000_000)
        
        XCTAssertTrue(viewModel.user.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
}
