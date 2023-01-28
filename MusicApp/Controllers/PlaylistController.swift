//
//  PlaylistController.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import UIKit

class PlaylistController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var model = ModelPlaylist()
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return PlaylistController.createSectionLayout(section: sectionIndex)
        }
    )
    
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: PlaylistCell.id)
        collectionView.register(PlaylistTrackCellDetails.self, forCellWithReuseIdentifier: PlaylistTrackCellDetails.id)
        
        
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
       
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundView = UIVieww()
        
        collectionView.snp.makeConstraints { make in
            
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        
        activityIndicator.frame = CGRect(x: 100, y: 100, width: 50, height: 50)
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
        }
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        
        self.model.viewController = self
 
        model.networkData()

    }
//MARK: - Data Source
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
        
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
  
        if section == 0 {
            
            return 1
        }
        
        if section == 1 {
            
            
            return model.playlistDetails.count
        }
        return section
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCell.id, for: indexPath) as! PlaylistCell
            
            cell.label.text = model.playlist.name
            cell.imageView.sd_setImage(with: model.playlist.images.first?.url)
            cell.labelDescription.text = model.playlist.description
            cell.button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)

            return cell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistTrackCellDetails.id, for:indexPath) as! PlaylistTrackCellDetails
 
            cell.labelNameTrack.text = model.playlistDetails[indexPath.row].track.name
            cell.labelNameArtist.text = model.playlistDetails[indexPath.row].track.artists.first?.name
            cell.imageView.sd_setImage(with: (model.playlistDetails[indexPath.row].track.album?.images.first?.url))
            cell.buttonAdd.addTarget(self, action: #selector(addTrackToPlaylist), for: .touchUpInside)
            cell.buttonLike.addTarget(self, action: #selector(addToLike), for: .touchUpInside)
            
//Selected Button
            let vc = LibraryLikeVC()
            let bool = vc.model.likesTracks.contains{$0 == model.playlistDetails[indexPath.row].track.name}
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
        let cell = collectionView.cellForItem(at: indexPath!) as! PlaylistTrackCellDetails
        
        guard let indexPath = indexPath else {return}
        if sender.isSelected  {
            sender.isSelected = false
            print("added")
            
            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            
            let vc = navVC.topViewController as! LibraryViewController
            
            vc.likesVC.model.likesTracks.append(model.playlistDetails[indexPath.row].track.name)
            vc.likesVC.model.likesArtist.append(model.playlistDetails[indexPath.row].track.artists.first!.name)
            
            print(vc.likesVC.model.likesTracks)
            print(vc.likesVC.model.likesArtist)
            
            var imageLikeFull = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
            
            sender.setImage(imageLikeFull, for: .normal)
            sender.tintColor = .white
            
            UserDefaults.standard.setValue(vc.likesVC.model.likesTracks, forKey: "names")
            UserDefaults.standard.setValue(vc.likesVC.model.likesArtist, forKey: "songs")
            
            tabBarController?.selectedIndex = 2 
            
        } else {
            sender.isSelected = true
            
            print("deleted")
            
            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            
            let vc = navVC.topViewController as! LibraryViewController
            
            var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
            
            sender.setImage(imageLike, for: .normal)
            sender.tintColor = .white
            
            vc.likesVC.model.likesTracks.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: "songs")
            
            vc.likesVC.model.likesArtist.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: "names")
            
            tabBarController?.selectedIndex = 2
            collectionView.reloadData()
         print(vc.likesVC.model.likesArtist.count)
        }
    }
    
//Add track to playlistLibrary
    @objc func addTrackToPlaylist(_ sender:UIButton){
        
        var alert = UIAlertController(title: "Добавить в плейлист?" ,
                                      message: "Трек будет добавлен",
                                      preferredStyle: .actionSheet)
        
        alert.view.tintColor = .darkGray
        let action = UIAlertAction(title: "ОК", style: .default) {[weak self] _ in
            
            var index = 0
            
            let vc = LibraryPlaylistVC()
            vc.selectionHandler = { [weak self] playlist in
                ApiCaller.sharedCaller.addTrackToPlaylist(track: (self?.model.playlistDetails[index].track)!, playlist: playlist) { succsses in
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
// Music playback
    @objc func buttonTap(_ sender:UIButton){
        let vc = PlayerViewController()
        vc.model.itemArray.append(contentsOf:  model.playlistDetails.compactMap({$0.track.preview_url!}))
        vc.model.imageView.append(contentsOf: model.playlistDetails.compactMap({$0.track.album?.images.first?.url}))
        vc.model.names.append(contentsOf:     model.playlistDetails.compactMap({$0.track.name}))
        vc.model.namesTrack.append(contentsOf: model.playlistDetails.compactMap({$0.track.artists.first?.name}))
        
        navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
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
            
        case 0 :
    //MARK:  Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
    //MARK:  Group
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),heightDimension:.fractionalHeight(0.3)),subitems: [item])
            groupItem.interItemSpacing = .fixed(100)
       
    //MARK: Section
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 50, bottom: 20, trailing: 20)
            
            return section
            
        case 1:
    //MARK:  Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
            item.contentInsets = .init(top:10, leading: 5, bottom: 10, trailing: 5)
            
        //MARK:  Group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
            
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.8)),subitems: [horizontalGroup])
            groupItem.contentInsets = .init(top: 5, leading: 0, bottom: 40, trailing: 10)
            
    //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging

            return section
            
        default:
        //MARK:  Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
 
        //MARK:  Group
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
        //MARK: Section
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
            
            return section
            
        }
    }
}



