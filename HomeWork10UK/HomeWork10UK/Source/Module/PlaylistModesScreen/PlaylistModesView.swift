//
//  PlaylistModesView.swift
//  Lesson12HW
//

//

import UIKit

protocol PlaylistModesViewDelegate: AnyObject {
    
}

class PlaylistModesView: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sectionSegmentController: UISegmentedControl!
    

    
    
    weak var delegate: PlaylistModesViewDelegate?
}
