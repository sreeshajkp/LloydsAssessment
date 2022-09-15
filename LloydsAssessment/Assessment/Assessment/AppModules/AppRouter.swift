//
//  ListViewRouter.swift
//  TestAssessment
//
//  Created by Sreeshaj KP on 09/09/2022.
//

import UIKit

protocol ListViewRouting {
    func showDetailPage(team: ASTeam)
}

class AppRouter: ListViewRouting {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showDetailPage(team: ASTeam) {
        let vc = AppBuilder.buildDetailedModule(team: team)
        self.navigationController.show(vc, sender: nil)
    }
    
}
