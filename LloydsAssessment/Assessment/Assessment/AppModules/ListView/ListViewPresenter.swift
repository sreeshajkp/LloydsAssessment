//
//  ListViewPresenter.swift
//  TestAssessment
//
//  Created by Sreeshaj KP on 09/09/2022.
//

import Foundation

protocol ListViewPresentee: AnyObject {
    func showList(_ dataSource: ListViewDatasSource)
}

protocol ListPresentingProtocol: AnyObject {

}

class ListViewPresenter {
    private weak var presentee: ListViewPresentee?
    private let router: ListViewRouting?
    private let interactor: ListViewInteracting?
    private var dataSource: ListViewDatasSource
    
    init(presentee: ListViewPresentee,
         router: ListViewRouting,
         interactor: ListViewInteracting?) {
        self.presentee = presentee
        self.router = router
        self.interactor = interactor
        self.dataSource = ListViewDatasSource(teams: [])
        self.dataSource.delegate = self
    }
    
    func presenteeDidLoad() {
        Task { @MainActor in
            do {
                if let teams = try await interactor?.getNoticeList() {
                    self.dataSource.teams = teams
                    self.presentee?.showList(self.dataSource)
                }
            } catch {
                print("#Error:: fetching details -", error)
            }
            
        }
    }
}

extension ListViewPresenter: ListViewSelectionDelegate {
    func didSelectTeam(team: ASTeam) {
        router?.showDetailPage(team: team)
    }
}
