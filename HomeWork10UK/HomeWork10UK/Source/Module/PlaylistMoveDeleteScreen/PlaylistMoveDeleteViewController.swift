//
//  PlaylistMoveDeleteViewController.swift
//  Lesson12HW
//

//

import UIKit

class PlaylistMoveDeleteViewController: UIViewController {
    
    @IBOutlet weak var contentView: PlaylistMoveDeleteView!
    var model: PlaylistMoveDeleteModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
        model.loadData()
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editMode))
    }
    
    private func setupInitialState() {
        
        model = PlaylistMoveDeleteModel()
        
        model.delegate = self
        
        contentView.delegate = self
        
        contentView.tableView.delegate = self
        contentView.tableView.dataSource = self
    }
                                                            
                                                            
    @objc func editMode() {
        contentView.tableView.isEditing.toggle()
        
        navigationItem.rightBarButtonItem?.title = contentView.tableView.isEditing ? "Done" : "Edit"
        }
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteModelDelegate {
    func dataDidLoad() {
        contentView.tableView.reloadData()
    }
    
    
}

extension PlaylistMoveDeleteViewController: PlaylistMoveDeleteViewDelegate {
    
}



extension PlaylistMoveDeleteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell") else {
            assertionFailure()
            return UITableViewCell()
        }
        
        cell.detailTextLabel?.numberOfLines = 0
        cell.textLabel?.text = model.items[indexPath.row].songTitle
        cell.detailTextLabel?.text = "Author - \(model.items[indexPath.row].author)\n" +
                                    "Almub - \(model.items[indexPath.row].albumTitle)\n" +
                                    "Genre - \(model.items[indexPath.row].genre)"
        
        return cell
    }
    
    
}

extension PlaylistMoveDeleteViewController: UITableViewDelegate {
    
}
