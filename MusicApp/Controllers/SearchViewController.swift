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
    
    var model = ModelSearch()
    var search = UISearchController(searchResultsController: SearchResultViewController())
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return SearchViewController.createSectionLayout(section: sectionIndex)
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.viewController = self
        
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
        
        model.getNetWork ()
    }
    
    func searchBarSearchButtonClicked(_ searchBar:UISearchBar){
        
        guard  let  resultSearch = search.searchResultsController as? SearchResultViewController,
               let query = search.searchBar.text,
               !query.trimmingCharacters(in: .whitespaces).isEmpty else {return}
        navigationController?.pushViewController(resultSearch, animated: true)
        
        ApiCaller.sharedCaller.search(query: query) { [weak resultSearch] result in
            
            DispatchQueue.main.async {
                switch result{
                    
                case.success(let model):
                    
                    resultSearch?.model.searchAlbums.append(contentsOf: model.albums.items.compactMap({$0}))
                    resultSearch?.model.searchArtist.append(contentsOf: model.artists.items.compactMap({$0}))
                    resultSearch?.model.searchTracks.append(contentsOf: model.tracks.items.compactMap({$0}))
                    resultSearch?.model.searchPlaylist.append(contentsOf: model.playlists.items.compactMap({$0}))
                    
                case.failure(let error):
                    print(error)
                }
            }
        }
        print(query)
        resultSearch.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
             return "Альбомы"
        }
        
        if section == 1 {
           
            return "Плейлисты"
            
        }
        
        if section == 2 {
            
            return "Артисты"
        }
        if section == 3 {
            
            return "Треки"
        }
        
        return nil
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  model.category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.id, for: indexPath) as! CategoryCell
        
        cell.label.text =  model.category[indexPath.row].name
        cell.imageView.sd_setImage(with: ( model.category[indexPath.row].icons.first?.url))
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
            
            //MARK: Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top:10, leading: 5, bottom: 5, trailing: 5)
            
            
            //MARK: Group
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2)), subitems: [item])
            
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1)),subitems: [horizontalGroup])
            groupItem.contentInsets = .init(top: 5, leading: 0, bottom: 20, trailing: 0)
            
            //MARK:  Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            
            
            return section
            
            
        default:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
            //MARK: Group
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
            
            //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
            
            return section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = CategoryController()
        vc.model.category = model.category[indexPath.row].self
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

