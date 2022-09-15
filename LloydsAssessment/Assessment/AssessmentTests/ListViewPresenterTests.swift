//
//  ListViewPresenterTests.swift
//  TestAssessmentTests
//
//  Created by Sreeshaj KP on 13/09/2022.
//

import XCTest
@testable import Assessment

class ListViewPresenterTests: XCTestCase {
    private var presenter: ListViewPresenter!
    private var presentee: MockPresentee!
    private var router: ListViewRouting!
    private var interactor: ListViewInteracting?
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        presentee = MockPresentee()
        router = MockRouter()
        interactor = MockListInteractor()
        presenter = ListViewPresenter(presentee: presentee,
                                     router: router,
                                     interactor: interactor)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        presentee = nil
        presenter = nil
        interactor = nil
        router = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func getTeams() -> [ASTeam] {
        return {
            let jsonData = """
[{
    "team_id": 2676492,
    "rating": 1109.9,
    "wins": 8,
    "losses": 0,
    "last_match_time": 1570903749,
    "name": "Virus Nirvana",
    "tag": "VirusN",
    "logo_url": "https://steamusercontent-a.akamaihd.net/ugc/169288024533455482/AFD3D7B6EDDFB610168D9DCACAEBA9922494FF49/"
  },
  {
    "team_id": 1148284,
    "rating": 1109.51,
    "wins": 336,
    "losses": 291,
    "last_match_time": 1481161727,
    "name": "MVP Phoenix",
    "tag": "MVP",
    "logo_url": "https://steamcdn-a.akamaihd.net/apps/dota2/images/team_logos/1148284.png"
  }]
""".data(using: .utf8)!
            
            return try! JSONDecoder().decode([ASTeam].self, from: jsonData)
        }()
    }
    
    
    func testShowList() {
        let teams = getTeams()
        let dataSource = ListViewDatasSource(teams: teams)
        presentee.showList(dataSource)
        XCTAssertEqual(presentee.dataSource?.teams.count, teams.count)
        XCTAssertEqual(presentee.dataSource?.teams, teams)
    }
    
    func testGetAPI() async {
        presenter.presenteeDidLoad()
        let teams = getTeams()
        do {
            let resultTeams = try await interactor?.getNoticeList()
            XCTAssertEqual(teams, resultTeams)
        } catch {
            debugPrint("error while mocking")
        }
    }
}

private class MockPresentee: ListViewPresentee {
    var dataSource: ListViewDatasSource?
    func showList(_ dataSource: ListViewDatasSource) {
        self.dataSource = dataSource
    }
}

private class MockRouter: ListViewRouting {
    var isDetailPageReached = false
    func showDetailPage(team: ASTeam) {
        isDetailPageReached = true
    }
}

private class MockListInteractor: ListViewInteracting {
    var teams: [ASTeam]?
    let expectation = XCTestExpectation()
    func getNoticeList() async throws -> [ASTeam]? {
        expectation.fulfill()
        
        let teams: [ASTeam] = {
            let jsonData = """
[{
    "team_id": 2676492,
    "rating": 1109.9,
    "wins": 8,
    "losses": 0,
    "last_match_time": 1570903749,
    "name": "Virus Nirvana",
    "tag": "VirusN",
    "logo_url": "https://steamusercontent-a.akamaihd.net/ugc/169288024533455482/AFD3D7B6EDDFB610168D9DCACAEBA9922494FF49/"
  },
  {
    "team_id": 1148284,
    "rating": 1109.51,
    "wins": 336,
    "losses": 291,
    "last_match_time": 1481161727,
    "name": "MVP Phoenix",
    "tag": "MVP",
    "logo_url": "https://steamcdn-a.akamaihd.net/apps/dota2/images/team_logos/1148284.png"
  }]
""".data(using: .utf8)!
            
            return try! JSONDecoder().decode([ASTeam].self, from: jsonData)
        }()
        
        return teams
        
    }
}
