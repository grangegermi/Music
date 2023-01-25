//
//  Class.swift
//  MusicApp
//
//  Created by Даша Волошина on 24.01.23.
//

import Foundation

class ModelHomeVC{
    
    weak var model:HomeViewController?
    
    var albums:[Album] = [] {
        didSet {
            DispatchQueue.main.async {
                self.model?.collectionView.reloadData()
            }
        }
    }
    
    var playlist:[Item] = [] {
        didSet {
            DispatchQueue.main.async {
                self.model?.collectionView.reloadData()
            }
        }
    }
    
    var tracksRecomendation:[AudioTrack] = [] {
        didSet {
            DispatchQueue.main.async {
                self.model?.collectionView.reloadData()
            }
        }
    }
    
    var category:[ItemsCategory] = []{
        didSet {
            DispatchQueue.main.async {
                self.model?.collectionView.reloadData()
            }
        }
    }
    
    func getNeetworkData() {
        let group = DispatchGroup()
        
        group.enter()
        ApiCaller.sharedCaller.getNewReleases { [weak self] result in
            
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.albums.append(contentsOf: model.albums.items.compactMap({$0}))
                }
            case.failure(let error):
                print(error)
                if error != nil {
                    DispatchQueue.main.async {
                        self?.model?.collectionView.refreshControl = self?.model?.myRefreshControl
                    }
                }
                
            default: break
            }
            group.leave()
        }
        
        group.enter()
        ApiCaller.sharedCaller.getFeaturedPlaylists { [weak self] result in
            
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.playlist.append(contentsOf: model.playlists.items.compactMap({$0}))
                }
            case .failure( let error):
                if error != nil {
                    DispatchQueue.main.async {
                        self?.model?.collectionView.refreshControl = self?.model?.myRefreshControl
                    }
                }
                print(error)
                
            default: break
            }
            group.leave()
        }
        
        group.enter()
        ApiCaller.sharedCaller.getRecommendations{ [weak self] result in
            
            switch result{
            case .success(let model):
                DispatchQueue.main.async {
                    self?.tracksRecomendation.append(contentsOf: model.tracks.filter{$0.preview_url != nil}.compactMap({$0}))
                }
            case .failure(let error):
                if error != nil {
                    DispatchQueue.main.async {
                        self?.model?.collectionView.refreshControl = self?.model?.myRefreshControl
                    }
                }
                print(error)
            default: break
            }
            
            group.leave()
        }
        group.notify(queue: .main) {
            self.model?.collectionView.reloadData()
        }
    }
    
}

