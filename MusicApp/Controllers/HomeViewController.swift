//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import SnapKit
import SDWebImage


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var modelVC = ModelHomeVC()

   lazy var myRefreshControl:UIRefreshControl =  {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshing), for: .valueChanged)
        return refresh
    }()
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modelVC.model = self
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundView = UIVieww()
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
            make.left.equalTo(view.snp.left)
            
        }
        
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Главная"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(buttonTap))]
        regitrationCell()
        self.modelVC.getNeetworkData()
        collectionView.reloadData()
    }
    

    @objc func refreshing(_ sender: UIRefreshControl){
        myRefreshControl.endRefreshing()
        modelVC.getNeetworkData()
        collectionView.reloadData()
    }
    
    func regitrationCell() {
        
        collectionView.register(AlbumCell.self, forCellWithReuseIdentifier:AlbumCell.id)
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier:TrackCell.id)
        collectionView.register(RecomendationCell.self, forCellWithReuseIdentifier: RecomendationCell.id)
        
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
            
            return modelVC.albums.count
        }
        
        if section == 1 {
            
            return modelVC.playlist.count
        }
        
        if section == 2 {
            
            return modelVC.tracksRecomendation.count
        }
        
        return section
    }
    
    //MARK: - Create Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()

        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.id, for: indexPath) as! AlbumCell
            
            
            cell.nameAlbums.text = modelVC.albums[indexPath.row].name
            
            cell.imageView.sd_setImage(with: modelVC.albums[indexPath.row].images.first?.url)
            cell.nameArtist.text = modelVC.albums[indexPath.row].artists.first?.name
            
            
            return cell
        }
       
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.id, for: indexPath) as! TrackCell
            
            cell.nameArtist.text = modelVC.playlist[indexPath.row].name
            cell.imageView.sd_setImage(with: modelVC.playlist[indexPath.row].images.first?.url)
            cell.nameDescription.text = modelVC.playlist[indexPath.row].description
            
            return  cell
        }

        if indexPath.section == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:RecomendationCell.id, for: indexPath) as! RecomendationCell
//CellDataSource
            cell.namePlaylist.text = modelVC.tracksRecomendation[indexPath.row].name
            cell.nameArtist.text = modelVC.tracksRecomendation[indexPath.row].artists.first?.name
            cell.imageView.sd_setImage(with: modelVC.tracksRecomendation[indexPath.row].album?.images.first?.url)
            cell.buttonAdd.addTarget(self, action: #selector(addTrackToPlaylist), for: .touchUpInside)
            cell.buttonLike.addTarget(self, action: #selector(addToLike), for: .touchUpInside)
     
//Selected Button
            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            let vc = navVC.topViewController as! LibraryViewController
            
            let bool = vc.likesVC.likesTracks.contains{$0 == modelVC.tracksRecomendation[indexPath.row].name}
            cell.buttonLike.isSelected = bool
            
            if  cell.buttonLike.isSelected {
                cell.buttonLike.isSelected = false
               var imageLike = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))

                cell.buttonLike.setImage(imageLike, for: .normal)
                cell.buttonLike.tintColor = .white
            }
            else {
                cell.buttonLike.isSelected = true
                
                var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))

                cell.buttonLike.setImage(imageLike, for: .normal)
                cell.buttonLike.tintColor = .white
            }
  
            return cell
        }
        return cell
    }
    
 //Add to likesController
    @objc func addToLike (_ sender:UIButton){
        
        var index = 0
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: buttonPosition)
        let cell = collectionView.cellForItem(at: indexPath!) as! RecomendationCell
        
        guard let indexPath = indexPath else {return}
        if sender.isSelected  {
            sender.isSelected = false
            print("added")

            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            
            let vc = navVC.topViewController as! LibraryViewController

            vc.likesVC.likesTracks.append(modelVC.tracksRecomendation[indexPath.row].name)
            vc.likesVC.likesSong.append(modelVC.tracksRecomendation[indexPath.row].artists.first!.name)
            
            print(vc.likesVC.likesTracks)
            print(vc.likesVC.likesSong)

            var imageLikeFull = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))

            sender.setImage(imageLikeFull, for: .normal)
            sender.tintColor = .white
            
            UserDefaults.standard.setValue(vc.likesVC.likesTracks, forKey: "names")
            UserDefaults.standard.setValue(vc.likesVC.likesSong, forKey: "songs")
            
            tabBarController?.selectedIndex = 2
           
            UserDefaults.standard.set(true, forKey: "isSelected")
            
        } else {
            sender.isSelected = true
     
            print("deleted")

            let navVC = tabBarController?.viewControllers![2] as! UINavigationController

            let vc = navVC.topViewController as! LibraryViewController
            
            var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))

            sender.setImage(imageLike, for: .normal)
            sender.tintColor = .white

            vc.likesVC.likesTracks.remove(at: indexPath.row)
            UserDefaults.standard.set(vc.likesVC.likesTracks, forKey: "songs")
            
            vc.likesVC.likesSong.remove(at: indexPath.row)
            UserDefaults.standard.set(vc.likesVC.likesSong, forKey: "names")
            
            tabBarController?.selectedIndex = 2

        }
    }
    
//Add to playlistController
    @objc func addTrackToPlaylist(_ sender:UIButton){
        
        var alert = UIAlertController(title: "Добавить в плейлист?" ,
                                      message: "Трек будет добавлен",
                                      preferredStyle: .actionSheet)
        
        alert.view.tintColor = .darkGray
        let action = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            
            var index = 0

            let vc = LibraryPlaylistVC()
            vc.selectionHandler = { [weak self] playlist in
            ApiCaller.sharedCaller.addTrackToPlaylist(track: (self?.modelVC.tracksRecomendation[index])!, playlist: playlist) { succsses in
                print("adding")
                }
            }
            self?.present(UINavigationController(rootViewController: vc),
                                                 animated: true,
                                                completion: nil)
            vc.modalPresentationStyle = .fullScreen
 
            }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
      
    //MARK: - Create Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header = UICollectionReusableView()
        
        if indexPath.section == 0 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier:HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
            header.label.text = "Новые релизы"
            header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
            return header
        }
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
            header.label.text = "Плейлист для тебя"
            header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
            return header
        }
        
        if indexPath.section == 2 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
            header.label.text = "Рекомендованные треки"
            header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
            return header
        }
        
        return header
    }
    
    //MARK: -  Create Layout
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
        //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(0))
        //Group
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.2)),subitems: [item])
       //Section
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 40, trailing: 20)
            
        //Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
            
        case 1 :
        //Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
       
        //Group
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
        //Section
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
            
        //Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
            
        case 2 :
        //Item
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1))))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(0), trailing: .flexible(5), bottom: .flexible(0))
        //Group
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.45)),subitems: [item])
        //Section
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading:0, bottom: 80, trailing: 0 )
        //Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
            
        default:
        //Item
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(0), trailing: .flexible(5), bottom: .flexible(0))
        //Group
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.25)),subitems: [item])
        //Section
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading:0, bottom: 10, trailing: 0 )
        //Header
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let vc = AlbumViewController()
            vc.model.album = modelVC.albums[indexPath.row].self
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 1 {
            let vc = PlaylistController()
            navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            vc.model.playlist = modelVC.playlist[indexPath.row].self
        }
        
        if indexPath.section == 2 {
            
            let vc = PlayerViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            vc.model.itemArray.append(modelVC.tracksRecomendation[indexPath.row].preview_url ?? "")
            vc.model.imageView.append((modelVC.tracksRecomendation[indexPath.row].album?.images.first?.url)!)
            vc.model.names.append(modelVC.tracksRecomendation[indexPath.row].name)
            vc.model.namesTrack.append(modelVC.tracksRecomendation[indexPath.row].artists.first?.name ?? "")
        }
    }
}


