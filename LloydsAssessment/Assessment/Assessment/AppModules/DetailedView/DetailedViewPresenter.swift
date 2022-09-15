//
//  DetailedViewPresenter.swift
//  Assessment
//
//  Created by Sreeshaj KP on 14/09/2022.
//

import Foundation

protocol DetailedViewPresentee: AnyObject {
    func showDetail(team: ASTeam)
}

class DetailedViewPresenter {
    private weak var presentee: DetailedViewPresentee?
    var team: ASTeam
    
    init(presentee: DetailedViewPresentee,
         team: ASTeam) {
        self.presentee = presentee
        self.team = team
    }
    
    func presenteeDidLoad() {
        presentee?.showDetail(team: team)
    }
}
