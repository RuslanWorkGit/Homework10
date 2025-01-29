//
//  PlaylistModesModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistModesModelDelegate: AnyObject {
    func dataDidLoad()
}

class PlaylistModesModel {
    
    weak var delegate: PlaylistModesModelDelegate?
    
    private let dataLoader = DataLoaderService()
    
    var items: [Song] = []
    var genreItem: [String: [Song]] = [:]
    var authorItem: [String: [Song]] = [:]
    var genres: [String] {
        genreItem.keys.sorted()
    }
    var authors: [String] {
        authorItem.keys.sorted()
    }
    
    func loadData() {
        dataLoader.loadPlaylist { playlist in
            self.items = playlist?.songs ?? []
            
            let songs = playlist?.songs ?? []
            self.genreItem = Dictionary(grouping: songs, by: { $0.genre })
            self.authorItem = Dictionary(grouping: self.items, by: { $0.author})
            self.delegate?.dataDidLoad()
        }
    }
}
