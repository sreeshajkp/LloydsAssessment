//
//  DetailedViewController.swift
//  Assessment
//
//  Created by Sreeshaj KP on 14/09/2022.
//

import UIKit

class DetailedViewController: UIViewController {
    @IBOutlet private var titleImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    
    var presenter: DetailedViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.presenteeDidLoad()
    }
}

//MARK: - DetailedViewPresentee Methods
extension DetailedViewController: DetailedViewPresentee {
    func showDetail(team: ASTeam) {
        self.descriptionLabel.text = "Team Name: \(team.name ?? "")\n Wins: \(team.wins ?? 0)\n Rating: \(team.rating ?? 0.00)\n Losses: \(team.losses ?? 0)\n Last match time: \(team.last_match_time ?? 0)"
        Task { @MainActor in
            if let source = team.logo_url,
               let url = URL(string: source) {
                titleImageView.image = try await APIManager.shared.imageDownloader(url: url)
            }
        }
    }
}
