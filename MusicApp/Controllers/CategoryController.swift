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
 
    var model = CategoryModel()
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return CategoryController.createSectionLayout(section: sectionIndex)
        })

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.viewController = self

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
        
        model.getNetwork()
        navigationController?.navigationBar.topItem?.title = "Категории"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        
    }
 //MARK: - DataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return model.categoryDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCellDetails.id, for: indexPath) as! CategoryCellDetails
        cell.namePlaylist.text = model.categoryDetails[indexPath.row].name
        cell.imageView.sd_setImage(with: model.categoryDetails[indexPath.row].images.first?.url)
            
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PlaylistController()
        vc.model.playlist = model.categoryDetails[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        
    }
  //MARK: - CreateLayot
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
    //MARK:  Item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top:10, leading: 5, bottom: 2, trailing: 5)
          
            
    //MARK: Group
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35)), subitems: [item])

            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(1)),subitems: [horizontalGroup])
            groupItem.contentInsets = .init(top: 5, leading: 0, bottom: 2, trailing: 0)
            
    //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
         
        
            return section
            
      
        default:
    //MARK: Item
            
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(0), trailing: .flexible(5), bottom: .flexible(0))
            
    //MARK: Group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.25)),subitems: [item])
            
    //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading:0, bottom: 10, trailing: 0 )
            
    //MARK: Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
     
    }
    
    
}
