//
//  LikesLibrary.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.01.23.
//

import Foundation

class LibraryLikes{
    
    weak var viewController: LibraryLikeVC?
    var likesTracks:[String] = [] {
        didSet{
            viewController?.tableView.reloadData()
        }
    }
    var likesArtist:[String] = []{
        didSet{
            viewController?.tableView.reloadData()
        }
    }
}

class PlaylistLibrary{
    
    weak var viewController: LibraryPlaylistVC?
    
    var playlist: [Item] = [] {
        
        didSet{
            viewController?.tableView.reloadData()
        }
    }
    
    func getData () {
        
        ApiCaller.sharedCaller.getPlaylistUser { [weak self] result in
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let userPlaylist):
                    
                    self?.playlist = userPlaylist.self
//                    print(self?.playlist.count)
                    
                case .failure(let error):
                    
                    print(error)
                }
            }
        }
        viewController?.tableView.reloadData()
    }
}
