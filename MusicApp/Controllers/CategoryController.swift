//
//  CategoryController.swift
//  MusicApp
//
//  Created by Даша Волошина on 9.01.23.
//

import UIKit
import SnapKit
import SDWebImage

class CategoryController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
 
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return CategoryController.createSectionLayout(section: sectionIndex)
        })
    var category = ItemsCategory(icons: [], id: "", name: "")
    var categoryDetails: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
        collectionView.backgroundView = UIVieww()
        collectionView.register(CategoryCellDetails.self, forCellWithReuseIdentifier: CategoryCellDetails.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
        }
        
        getNetwork()
        navigationController?.navigationBar.topItem?.title = "Категории"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        
    }
    func getNetwork() {
        let group = DispatchGroup()
        group.enter()
        ApiCaller.sharedCaller.getCategoryDetails(category: category) {[weak self] result in
            switch result {
            case.success(let model):
                self?.categoryDetails.append(contentsOf: model.playlists.items.compactMap({$0}))
            case .failure(let error):
                print(error)
                
            }
            group.leave()
        }
        group.notify(queue: .main){
            self.collectionView.reloadData()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categoryDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellDetails.id, for: indexPath) as! CategoryCellDetails
        cell.namePlaylist.text = categoryDetails[indexPath.row].name
        cell.imageView.sd_setImage(with: categoryDetails[indexPath.row].images.first?.url)
            
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlaylistController()
        vc.playlist = categoryDetails[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        
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
            //MARK: -  item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top:10, leading: 5, bottom: 2, trailing: 5)
          
            
            //MARK: -  group
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35)), subitems: [item])

            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1)),subitems: [horizontalGroup])
            groupItem.contentInsets = .init(top: 5, leading: 0, bottom: 2, trailing: 0)
            
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
         
        
            return section
            
      
        default:
            //MARK: -  Item
            
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(0), trailing: .flexible(5), bottom: .flexible(0))
            
            //MARK: - Group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.25)),subitems: [item])
            
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading:0, bottom: 10, trailing: 0 )
            
            //MARK: - Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
     
    }
    
    
}
