//
//  ModelAlbumVC.swift
//  MusicApp
//
//  Created by Даша Волошина on 26.01.23.
//

import Foundation
import UIKit

class ModelAlbum {
    
    weak var viewController:AlbumViewController?
    
    var album = Album(album_type: "",
                      available_markets: [],
                      id: "", images: [],
                      name: "",
                      release_date: "",
                      total_tracks: 0,
                      artists: [])
    
    var albumDetails:[AudioTrack] = [] {
        didSet {
            viewController?.collectionView.reloadData()
        }
    }
    
    
    func getDataNetwork() {
    
        ApiCaller.sharedCaller.getAlbumsDetail(album: album) { [weak self] result  in
            
            DispatchQueue.main.async {
                
                switch result{
                case.success(let model):
                    
                    self?.albumDetails.append(contentsOf: model.tracks.items.filter{$0.preview_url != nil}.compactMap({$0}))
                    
                    if self!.albumDetails.isEmpty {
                        self?.viewController?.createAlert()
                    }
                    
                case.failure(let error):
                    print(error)
                }
            }
        }
        self.viewController?.collectionView.reloadData()
    }
}

