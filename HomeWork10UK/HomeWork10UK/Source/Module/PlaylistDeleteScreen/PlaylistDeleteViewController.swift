//
//  PlaylistDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistDeleteView!
    var model: PlaylistDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistDeleteModel()
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
        
    }
}

extension PlaylistDeleteViewController: PlaylistDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
    
    
}

extension PlaylistDeleteViewController: PlaylistDeleteViewDelegate {
    
}

extension PlaylistDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.textLabel?.text = model.items[indexPath.row].songTitle
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.text = "Genre: \(model.items[indexPath.row].genre)\n" +
                                    "Album Title: \(model.items[indexPath.row].albumTitle)\n" +
                                    "Author: \(model.items[indexPath.row].author)"
        
        return cell
                
    }
    

    
    
}

extension PlaylistDeleteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            model.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    

}
