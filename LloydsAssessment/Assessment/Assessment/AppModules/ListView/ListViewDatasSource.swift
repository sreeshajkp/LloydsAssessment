//
//  ListViewDatasSource.swift
//  TestAssessment
//
//  Created by Sreeshaj KP on 10/09/2022.
//

import Foundation
import UIKit


protocol ListViewSelectionDelegate: AnyObject {
    func didSelectTeam(team: ASTeam)
}

class ListViewDatasSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    var teams: [ASTeam]
    weak var delegate: ListViewSelectionDelegate?
    
    init(teams: [ASTeam]) {
        self.teams = teams
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListViewTableCell", for: indexPath) as! ListViewTableCell
        let team = teams[indexPath.row]
        Task { @MainActor in
            let image: UIImage?
            if let source = team.logo_url,
               let url = URL(string: source) {
                print("URL - ", url)
                image = try await APIManager.shared.imageDownloader(url: url)
                let description = "Wins: #\(team.wins ?? 0)\n Rating: #\(team.rating ?? 0.0)\n Losses: #\(team.losses ?? 0)"
                cell.setUp(title: team.name,
                           descrition: description,
                           image: image)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let team = teams[indexPath.row]
        delegate?.didSelectTeam(team: team)
    }
}
