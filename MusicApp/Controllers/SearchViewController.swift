//
//  SearchViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//


import UIKit
import SnapKit
import SDWebImage

class SearchViewController: UIViewController,UISearchBarDelegate, UISearchResultsUpdating, UICollectionViewDelegate, UICollectionViewDataSource {

    var category:[ItemsCategory] = []
    
    var search = UISearchController(searchResultsController: SearchResultViewController())
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return SearchViewController.createSectionLayout(section: sectionIndex)
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundView = UIVieww()
        search.searchBar.barStyle = .default
        search.searchBar.placeholder = "Альбомы, Артисты, Плейлисты"
        search.definesPresentationContext = true
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    
        navigationController?.navigationBar.topItem?.title = "Поиск"
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationItem.searchController = search
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
       
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.id)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
        }
     
        getNetWork ()
    }
    func getNetWork () {
        
     var group = DispatchGroup()
        
        group.enter()
            ApiCaller.sharedCaller.getCategory {[weak self] result in
            
                switch result {
                    case.success(let model):
                        self?.category.append(contentsOf: model.categories.items.compactMap({$0}))
                    case.failure(let error):
                        print(error)
                }
            
                group.leave()
            }

        group.notify(queue: .main) {
            self.collectionView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar:UISearchBar){
        
        let group = DispatchGroup()
        guard  let  resultSearch = search.searchResultsController as? SearchResultViewController,
                let query = search.searchBar.text,
               !query.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        navigationController?.pushViewController(resultSearch, animated: true)
        group.enter()
         ApiCaller.sharedCaller.search(query: query) { result in
            
             switch result{
                 
             case.success(let model):
                 resultSearch.searchAlbums.append(contentsOf: model.albums.items.compactMap({$0}))
                 resultSearch.searchArtist.append(contentsOf: model.artists.items.compactMap({$0}))
                 resultSearch.searchTracks.append(contentsOf: model.tracks.items.compactMap({$0}))
                 resultSearch.searchPlaylist.append(contentsOf: model.playlists.items.compactMap({$0}))
//                 print(resultSearch.search.count)
//
                 
             case.failure(let error):
                 print(error)
             }
             group.leave()
        }
        print(query)
        group.notify(queue: .main){
            print("all")
            resultSearch.tableView.reloadData()
        }
       
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        
        cell.label.text = category[indexPath.row].name
        cell.imageView.sd_setImage(with: (category[indexPath.row].icons.first?.url))
        return cell
    }

    func updateSearchResults(for searchController: UISearchController) {
        
        
    }

        static func createSectionLayout(section: Int) -> NSCollectionLayoutSection {
            let supplementaryViews = [
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(50)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
            ]
            
            switch section {
                
            case 0:
                
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top:10, leading: 5, bottom: 5, trailing: 5)
              
                
                //MARK: -  group
                
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [item])
  
                
                let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1)),subitems: [horizontalGroup])
                groupItem.contentInsets = .init(top: 5, leading: 0, bottom: 20, trailing: 0)
                
                //MARK: -  Section
                
                let section = NSCollectionLayoutSection(group: groupItem )
                section.orthogonalScrollingBehavior = .paging
             
            
                return section
                
                
            default:
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
                item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
                //MARK: -  group
                
                let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
                
                //MARK: -  Section
                
                let section = NSCollectionLayoutSection(group: groupItem )
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
          
                return section
            }
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryController()
        vc.category = category[indexPath.row].self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

