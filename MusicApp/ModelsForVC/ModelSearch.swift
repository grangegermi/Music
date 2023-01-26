//
//  ModelSeach.swift
//  MusicApp
//
//  Created by Даша Волошина on 26.01.23.
//

import Foundation

class ModelSearch {
    
    weak var viewController:SearchViewController?
    
    var category:[ItemsCategory] = [] {
        didSet{
            viewController?.collectionView.reloadData()
        }
    }
    
    func getNetWork () {
    
            ApiCaller.sharedCaller.getCategory { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                        case.success(let model):
                            self?.category.append(contentsOf: model.categories.items.compactMap({$0}))
                        case.failure(let error):
                            print(error)
                    }
                }
            }
        viewController?.collectionView.reloadData()
    }
}

class ModelSearchResult {
    
    weak var viewController: SearchResultViewController?
    
    var searchAlbums:[Album] = [] {
        
        didSet {
            viewController?.tableView.reloadData()
        }
    }
    
    var searchPlaylist:[Item] = [] {
        
        didSet {
            viewController?.tableView.reloadData()
        }
    }
    
    
    var searchArtist:[Artist] = [] {
        
        didSet {
            viewController?.tableView.reloadData()
        }
    }
    
    var searchTracks:[AudioTrack] = []{
        didSet {
            viewController?.tableView.reloadData()
        }
    }
    
    
}
