//
//  List
//  TestAssessment
//
//  Created by Sreeshaj KP on 09/09/2022.
//

import UIKit

struct AppBuilder {
    static func buildListModule(navigationController: UINavigationController) -> ListViewController {
        let vc = AppUtility.mainstoryboard.instantiateViewController(withIdentifier: "ListViewController") as! ListViewController
        vc.presenter = ListViewPresenter(presentee: vc,
                                           router: AppRouter(navigationController: navigationController),
                                           interactor: ListViewInteractor())
        
        return vc
    }
    
    static func buildDetailedModule(team: ASTeam) -> DetailedViewController {
        let vc = AppUtility.mainstoryboard.instantiateViewController(withIdentifier: "DetailedViewController") as! DetailedViewController
        vc.presenter = DetailedViewPresenter(presentee: vc,
                                               team: team)
        return vc
    }
}
