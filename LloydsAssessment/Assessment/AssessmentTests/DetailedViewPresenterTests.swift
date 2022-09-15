//
//  DetailedViewPresenterTests.swift
//  AssessmentTests
//
//  Created by Sreeshaj KP on 14/09/2022.
//

import XCTest
@testable import Assessment

class DetailedViewPresenterTests: XCTestCase {
    private var presnter: DetailedViewPresenter!
    private var presentee: MockPresentee!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presentee = MockPresentee()
        presnter = DetailedViewPresenter(presentee: presentee,
                                         team: getStubTeam())
    }
    
    override func tearDownWithError() throws {
        presentee = nil
        presnter = nil
        try super.tearDownWithError()
    }
    
    func getStubTeam() -> ASTeam {
        return  {
            let jsonData = """
{
    "team_id": 2676492,
    "rating": 1109.9,
    "wins": 8,
    "losses": 0,
    "last_match_time": 1570903749,
    "name": "Virus Nirvana",
    "tag": "VirusN",
    "logo_url": "https://steamusercontent-a.akamaihd.net/ugc/169288024533455482/AFD3D7B6EDDFB610168D9DCACAEBA9922494FF49/"
  }
""".data(using: .utf8)!
            
            return try! JSONDecoder().decode(ASTeam.self, from: jsonData)
        }()
    }
    
    func testShowDetail() {
        presentee?.showDetail(team: getStubTeam())
        XCTAssertEqual(getStubTeam(), presentee.team)
    }
    
}

private class MockPresentee: DetailedViewPresentee {
    var team: ASTeam?
    func showDetail(team: ASTeam) {
        self.team = team
    }
}
