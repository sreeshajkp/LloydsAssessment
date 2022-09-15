//
//  ViewController.swift
//  Assessment
//
//  Created by Sreeshaj KP on 13/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet private var listTable: UITableView!
    var dataSource: ListViewDatasSource!
    var presenter: ListViewPresenter?
    var teams: [ASTeam] = []
        @IBOutlet weak var firstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTable.estimatedRowHeight = 60
        listTable.rowHeight = UITableView.automaticDimension
        presenter?.presenteeDidLoad()
    }
}

//MARK: - ListViewPresentee Methods
extension ListViewController: ListViewPresentee {
    func showList(_ dataSource: ListViewDatasSource) {
                self.teams = dataSource.teams
        listTable.dataSource = dataSource
        listTable.delegate = dataSource
        listTable.reloadData()
    }
}

//MARK: - TableView Delegates and DataSources
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
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
                cell.setUp(title: team.name,
                           descrition: team.logo_url,
                           image: image)
            }
        }
        return cell
    }
}

class ListViewTableCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDesc: UILabel!
    
    func setUp(title: String?,
               descrition: String?,
               image: UIImage?) {
        self.movieTitle.text = title
        self.movieDesc.text = descrition
        self.movieImageView.image = image
    }
}
