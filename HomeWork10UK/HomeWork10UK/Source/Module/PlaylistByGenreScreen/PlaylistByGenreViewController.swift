//
//  PlaylistByGenreViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistByGenreViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistByGenreView!
    var model: PlaylistByGenreModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupInitialState()
        model.loadData()
    }
    
    private func setupInitialState() {
        
        model = PlaylistByGenreModel()
        model.delegate = self
        contentView.delegate = self

        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
}

extension PlaylistByGenreViewController: PlaylistByGenreModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
    
    
}

extension PlaylistByGenreViewController: PlaylistByGenreViewDelegate {
    
}

extension PlaylistByGenreViewController: UITableViewDelegate {
    
}

extension PlaylistByGenreViewController: UITableViewDataSource {
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
        cell.detailTextLabel?.text = "Author - \(model.items[indexPath.row].author)\n" + "Album title - \(model.items[indexPath.row].albumTitle)\n" + "Genre - \(model.items[indexPath.row].genre)\n"
        return cell
    }
    
    
}
