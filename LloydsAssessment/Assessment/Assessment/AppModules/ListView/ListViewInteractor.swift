//
//  ListViewInteractor.swift
//  TestAssessment
//
//  Created by Sreeshaj KP on 09/09/2022.
//

import Foundation

struct ApiList {
    let teamList: String = "https://api.opendota.com/api/teams"
}

protocol ListViewInteracting {
    func getNoticeList() async throws -> [ASTeam]?
}

class ListViewInteractor: ListViewInteracting {
    func getNoticeList() async throws -> [ASTeam]? {
        if let url = URL(string: ApiList().teamList) {
            return try await APIManager.shared.getNoticeList(url: url)
        } else {
            return nil
        }
    }
}
