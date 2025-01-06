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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        model.genres.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let genre = model.genres[section]
        return model.groupedItems[genre]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let genre = model.genres[indexPath.section]
        if let song = model.groupedItems[genre]?[indexPath.row] {
            cell.textLabel?.text = song.songTitle
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = "Author - \(song.author)\n" + "Album title - \(song.albumTitle)\n"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        model.genres[section]
    }
    
    
}
