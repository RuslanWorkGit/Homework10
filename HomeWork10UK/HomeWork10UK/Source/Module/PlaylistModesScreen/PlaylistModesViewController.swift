//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistModesViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistModesView!
    var model: PlaylistModesModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        model = PlaylistModesModel()
        
        model.delegate = self
        contentView.delegate = self
        
        contentView.tableView.dataSource = self
        contentView.tableView.delegate = self
    }
}

extension PlaylistModesViewController: PlaylistModesModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
}

extension PlaylistModesViewController: PlaylistModesViewDelegate {
    
}

extension PlaylistModesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.textLabel?.text = model.items[indexPath.row].songTitle
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "Author - \(model.items[indexPath.row].author)\n" + "Album name - \(model.items[indexPath.row].albumTitle)\n" + "Genre - \(model.items[indexPath.row].genre)"
        
        return cell
    }
    
    
}

extension PlaylistModesViewController: UITableViewDelegate {
    
}
