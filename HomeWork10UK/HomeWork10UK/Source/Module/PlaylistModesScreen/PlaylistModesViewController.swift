//
//  PlaylistModesViewController.swift
//  Lesson12HW
//

//

import UIKit

enum Section {
    case All
    case Genres
    case Authors
}

class PlaylistModesViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistModesView!
    var model: PlaylistModesModel!
    var mySection: Section = .All
    
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
        
        contentView.sectionSegmentController.addTarget(self, action: #selector(changeView(_:)), for: .valueChanged)
    }
    
    @objc private func changeView(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: mySection = .All
            print("turn all")
        case 1: mySection = .Genres
            print("turn genre")
        case 2: mySection = .Authors
            print("turn authors")
        default: mySection = .All
        }
        
        contentView.tableView.reloadData()
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
    func numberOfSections(in tableView: UITableView) -> Int {
        switch mySection {
        case .All: return 1
        case .Genres: return model.genres.count
        case .Authors: return model.authors.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch mySection {
        case .All: return model.items.count
            
        case .Genres:
            let genre = model.genres[section]
            print("Sections count: \(model.genres.count), Rows in section \(section): \(model.genreItem[genre]?.count ?? 0)")
            return model.genreItem[genre]?.count ?? 0
        case .Authors:
            let author = model.authors[section]
            print("Sections count: \(model.authors.count), Rows in section \(section): \(model.authorItem[author]?.count ?? 0)")
            return model.authorItem[author]?.count ?? 0
        }
        


    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.detailTextLabel?.numberOfLines = 0
        
        switch mySection {
        case .All:
            cell.textLabel?.text = model.items[indexPath.row].songTitle
            cell.detailTextLabel?.text = "Author - \(model.items[indexPath.row].author)\n" + "Album name - \(model.items[indexPath.row].albumTitle)\n" + "Genre - \(model.items[indexPath.row].genre)"
            
        case .Genres:
            let genre = model.genres[indexPath.section]
            print("Accessing genre: \(genre), Songs count: \(model.genreItem[genre]?.count ?? 0)")
            if let song = model.genreItem[genre]?[indexPath.row] {
                cell.textLabel?.text = song.songTitle
                cell.detailTextLabel?.text = "Author - \(song.author)\n" + "Album title - \(song.albumTitle)\n"
            } else {
                assertionFailure("Index out of range: section \(indexPath.section), row \(indexPath.row)")
            }
            
        
        case .Authors:
            let author = model.authors[indexPath.section]
            print("Accessing author: \(author), Songs count: \(model.authorItem[author]?.count ?? 0)")
            if let song = model.authorItem[author]?[indexPath.row] {
                cell.textLabel?.text = song.songTitle
                cell.detailTextLabel?.text = "Album title - \(song.albumTitle)" + "Genre - \(song.genre)"
            }
            
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch mySection {
        case .All: return ""
        case .Genres: return model.genres[section]
        case .Authors: return model.authors[section]
        }
    }
    
}

extension PlaylistModesViewController: UITableViewDelegate {
    
}
