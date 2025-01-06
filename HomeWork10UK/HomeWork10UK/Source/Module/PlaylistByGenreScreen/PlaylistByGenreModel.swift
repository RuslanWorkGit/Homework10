//
//  PlaylistByGenreModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistByGenreModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistByGenreModel {
    
    weak var delegate: PlaylistByGenreModelDelegate?
    
    private let dataLoader = DataLoaderService()
    
    var groupedItems: [String: [Song]] = [:]
    var genres: [String] { groupedItems.keys.sorted() }
    
    func loadData() {
        dataLoader.loadPlaylist { playlist in
            let songs = playlist?.songs ?? []
            self.groupedItems = Dictionary(grouping: songs, by: { $0.genre })
            self.delegate?.dataDidLoad()
        }
    }
}
