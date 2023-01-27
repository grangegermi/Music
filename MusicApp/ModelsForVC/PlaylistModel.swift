//
//  PlaylistModel.swift
//  MusicApp
//
//  Created by Даша Волошина on 26.01.23.
//

import Foundation

class ModelPlaylist {
    
    weak var viewController: PlaylistController?
    
    var playlistDetails:[Items] = [] {
        
        didSet {
            viewController?.collectionView.reloadData()
        }
    }
    
    var playlist = Item(description: "", id: "", images: [], name: "")
    
    func networkData () {
        
        viewController?.activityIndicator.startAnimating()
        ApiCaller.sharedCaller.getPlaylists(playlist: self.playlist) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.playlistDetails.append(contentsOf: model.tracks.items.filter{$0.track.preview_url != nil}.compactMap({$0}))
                    self?.viewController?.activityIndicator.stopAnimating()
                case.failure(let error):
                    print(error)
                }
            }
        }
        viewController?.collectionView.reloadData()
    }
}
