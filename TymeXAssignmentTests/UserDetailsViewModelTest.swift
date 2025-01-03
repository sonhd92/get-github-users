//
//  UserDetailsViewModelTest.swift
//  TymeXAssignmentTests
//
//  Created by Son Hoang Duc on 3/1/25.
//

import XCTest
@testable import TymeXAssignment

final class UserDetailsViewModelTest: XCTestCase {
    var viewModel: UserDetailsViewModel!
    var mockService: MockServiceManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        mockService = MockServiceManager()
        viewModel = UserDetailsViewModel(service: mockService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockService = nil
        try super.tearDownWithError()
    }
    
    func testLoadUserDetails_Success() async {
        let testUserDetails = UserDetails(name: "Test User", bio: "This is test bio", followers: 100, following: 10, publicRepos: 2, location: "Vietnam")
        mockService.userDetails = testUserDetails
        
        await viewModel.loadUserDetails(username: "testuser")
        
        XCTAssertEqual(viewModel.userDetails?.name, "Test User")
        XCTAssertEqual(viewModel.userDetails?.bio, "This is test bio")
        XCTAssertEqual(viewModel.userDetails?.followers, 100)
        XCTAssertEqual(viewModel.userDetails?.following, 10)
        XCTAssertEqual(viewModel.userDetails?.publicRepos, 2)
        XCTAssertEqual(viewModel.userDetails?.location, "Vietnam")
        XCTAssertNil(viewModel.error)
    }
    
    func testLoadUserDetails_Failure() async {
        struct TestError: Error {}
        mockService.error = TestError()
        
        await viewModel.loadUserDetails(username: "testuser")
        
        XCTAssertNil(viewModel.userDetails)
        XCTAssertNotNil(viewModel.error)
    }
}
