//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import SnapKit
import SDWebImage


class HomeViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    var collectionView = UICollectionView ()
    var albums:[Album] = []
    var playlist: [Item] = []
    var tracks: [Tracks] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Home"
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(buttonTap)),
                                               UIBarButtonItem(image: UIImage(systemName: "bell"),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(buttonTap))]
        
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: createCollectionViewLayout())
        
        view.addSubview(collectionView)
        
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
            
        }
        
        collectionView.dataSource = self
        collectionView.delegate = self

//        getNeetworkData()
 
        regitrationCell()
    }

//    func getNeetworkData() {
//
//
//    }
    
    func regitrationCell() {
        
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier:TrackCell.id)
        collectionView.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.id)
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier:AlbumCell.id)
        collectionView.register(HeaderCollectionViewCell.self, forSupplementaryViewOfKind:  HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id)
    }
    
    @objc func buttonTap(_ sender:UIButton){
        
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
    }

   //MARK: - DataSource
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            
            return 3
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            if section == 0 {
               
                return albums.count
            }
            
            if section == 1 {
                
                return tracks.count
            }
            
            if section == 2 {
               
                return playlist.count
            }

            return section
        }
        
    //MARK: - Create Cell
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = UICollectionViewCell()
    //MARK: -  First
            if indexPath.section == 0 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.id, for: indexPath) as! AlbumCell
         
                cell.imageView.sd_setImage(with: albums[indexPath.row].images[indexPath.row].url)
                cell.imageView.layer.cornerRadius = 10
                cell.imageView.layer.masksToBounds = true

                cell.nameAlbums.text = albums[indexPath.row].name
                cell.nameArtist.text = albums[indexPath.row].artists[indexPath.row].name
                return cell
                
            }
    //MARK: -  Second
            if indexPath.section == 1 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.id, for: indexPath) as! TrackCell
                
                cell.imageView.layer.cornerRadius = 6
                cell.imageView.layer.masksToBounds = true
                cell.imageView.sd_setImage(with: playlist[indexPath.row].images[indexPath.row].url)
                cell.imageView.layer.cornerRadius = 40
                cell.imageView.layer.masksToBounds = true

                cell.namePlaylist.text = playlist[indexPath.row].name
                
                return cell
            }
     //MARK: -  Third
            if indexPath.section == 2 {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier:RecomendationCell.id, for: indexPath) as! RecomendationCell
                
          
                cell.imageView.layer.cornerRadius = 6
                cell.imageView.layer.masksToBounds = true
                cell.imageView.sd_setImage(with:tracks[indexPath.row].album.images[indexPath.row].url)
                cell.imageView.layer.cornerRadius = 40
                cell.imageView.layer.masksToBounds = true

                cell.namePlaylist.text = tracks[indexPath.row].name
                
                return cell
            }
            return cell
        }
    //MARK: -  Create Layout
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self]  (index, enviroment) ->  NSCollectionLayoutSection? in
            
            return self?.createSection(index:index, enviroment:enviroment)
        }
        return layout
    }
        
        func createSection(index:Int, enviroment:NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
            
            switch index {
            case 0:
                return createFirstSection()
            case 1 :
                return  createSecondSection()
            case 2 :
                return createThirdSection()
          
            default:
                return createFirstSection()
            }
            
        }
    //MARK: -  First Layout
        
        func createFirstSection() -> NSCollectionLayoutSection {
            
    //MARK: -  item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(10), trailing: .flexible(5), bottom: .flexible(0))
            
    //MARK: -  group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.4)),subitems: [item])

     //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 60, leading: 10, bottom: 40, trailing: 0)
            
    //MARK: -  Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
      
        }
    //MARK: -  Second Layout
        func createSecondSection() -> NSCollectionLayoutSection {
    //MARK: -  Item
            
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))))
                                              
     //MARK: - Group
                                              
            let groupItem  = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)),subitems: [item])
                                              
    //MARK: -  Section
                                              
            let section = NSCollectionLayoutSection(group: groupItem)
            section.contentInsets = .init(top: 10, leading: 0, bottom: 40, trailing: 0 )
            
    //MARK: - Header
                                              
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
    //MARK: -  Third Layout
                                              
        func  createThirdSection()-> NSCollectionLayoutSection {
            
    //MARK: -  Item
                
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .fractionalHeight(1))))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(0), trailing: .flexible(5), bottom: .flexible(0))
            
     //MARK: - Group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.4)),subitems: [item])
    //        groupItem.interItemSpacing = .flexible(10)
    //        groupItem.contentInsets = .init(top: 5, leading: 10, bottom: 0, trailing: 0)
            
    //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading:0, bottom: 40, trailing: 0 )
            
    //MARK: - Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }

       
    //MARK: -  Create Header
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            
            var header = UICollectionReusableView()
            
            if indexPath.section == 0 {
                
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier:HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
                header.label.text = "Album"
                header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 14)
                
                return header
            }
            
            if indexPath.section == 1 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
                header.label.text = "New Tracks"
                header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
                return header
            }
            
            if indexPath.section == 2 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
                header.label.text = "Recomendation"
                header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
                return header
            }
           
            return header
        }
        
        
    }




