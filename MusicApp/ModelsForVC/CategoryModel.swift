//
//  CategoryModel.swift
//  MusicApp
//
//  Created by Даша Волошина on 26.01.23.
//

import Foundation

class CategoryModel {
    
    weak var viewController: CategoryController?
    
    var categoryDetails: [Item] = [] {
        
        didSet {
            viewController?.collectionView.reloadData()
        }
    }
    
    var category = ItemsCategory(icons: [], id: "", name: "")

    func getNetwork() {
   
        ApiCaller.sharedCaller.getCategoryDetails(category: category) { [weak self] result in
            
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    self?.categoryDetails.append(contentsOf: model.playlists.items.compactMap({$0}))
                case .failure(let error):
                    print(error)
                }
            }
        }
        viewController?.collectionView.reloadData()
    }
}
