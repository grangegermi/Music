//
//  AlbumViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 1.01.23.
//

import UIKit
import SDWebImage
import SnapKit

class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var model = ModelAlbum()
    
    var track = AudioTrack(album: Album(album_type: "",
                                        available_markets: [],
                                        id: "",
                                        images: [],
                                        name: "",
                                        release_date: "",
                                        total_tracks: 0,
                                        artists: []),
                           artists: [],
                           available_markets: [],
                           disc_number: 0,
                           duration_ms: 0,
                           explicit: true,
                           external_urls: ["":""],
                           id: "",
                           name: "",
                           preview_url: "")
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return AlbumViewController.createSectionLayout(section: sectionIndex)
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        collectionView.register(AlbumCellDetails.self, forCellWithReuseIdentifier: AlbumCellDetails.id)
        
        collectionView.register(AlbumCellDetailsTraks.self, forCellWithReuseIdentifier: AlbumCellDetailsTraks.id)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundView = UIVieww()
        collectionView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
        }
        model.getDataNetwork()
        self.model.viewController = self
        
    }
//CreateAlert for unavailable albums
    func  createAlert(){
        var vc = UIAlertController(title: "Сообщение", message: "Альбом недоступен", preferredStyle: .alert)
        vc.view.tintColor = .gray
        let action = UIAlertAction(title: "ОK", style: .cancel)
        vc.addAction(action)
        self.present(vc, animated: true)
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
            
            return  model.albumDetails.count
        }
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCellDetails.id, for: indexPath) as! AlbumCellDetails
            
            cell.label.text = model.album.name
            cell.imageView.sd_setImage(with: model.album.images.first?.url)
            cell.labelDescription.text = model.album.release_date
            return cell
        }
        
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCellDetailsTraks.id, for: indexPath) as! AlbumCellDetailsTraks
            
            
            cell.labelNameArtist.text = model.albumDetails[indexPath.row].artists.first?.name
            cell.labelNameTrack.text = model.albumDetails[indexPath.row].name
            cell.labelNumber.text = "\((indexPath.row) + 1)"
            
            cell.buttonAdd.addTarget(self, action: #selector(addTrackToPlaylist), for: .touchUpInside)
            cell.buttonAdd.tag = indexPath.row
            
            cell.buttonLike.addTarget(self, action: #selector(addToLike), for: .touchUpInside)
            cell.buttonLike.tag = indexPath.row
            
            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            let vc = navVC.topViewController as! LibraryViewController
            let bool = vc.likesVC.model.likesTracks.contains{$0 == model.albumDetails[indexPath.row].name}
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
//Add To Like
    @objc func addToLike (_ sender:UIButton){
        
        var index = 0
        let buttonPosition: CGPoint = sender.convert(CGPoint.zero, to: collectionView)
        let indexPath = collectionView.indexPathForItem(at: buttonPosition)
        let cell = collectionView.cellForItem(at: indexPath!) as! AlbumCellDetailsTraks
        
        guard let indexPath = indexPath else {return}
        
        if sender.isSelected  {
            sender.isSelected = false
            print("added")
            
            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            
            let vc = navVC.topViewController as! LibraryViewController
            
            vc.likesVC.model.likesTracks.append(model.albumDetails[indexPath.row].name)
            vc.likesVC.model.likesArtist.append(model.albumDetails[indexPath.row].artists[indexPath.row].name)
            
            print(vc.likesVC.model.likesTracks)
            print(vc.likesVC.model.likesArtist)
            
            var imageLikeFull = UIImage(systemName: "suit.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
            
            sender.setImage(imageLikeFull, for: .normal)
            sender.tintColor = .white
            
            UserDefaults.standard.setValue(vc.likesVC.model.likesTracks, forKey: "names")
            UserDefaults.standard.setValue(vc.likesVC.model.likesArtist, forKey: "songs")
            
            
            tabBarController?.selectedIndex = 2
            
        } else  {
            sender.isSelected = true
            
            print("deleted")
            
            let navVC = tabBarController?.viewControllers![2] as! UINavigationController
            
            let vc = navVC.topViewController as! LibraryViewController
            
            var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
            
            sender.setImage(imageLike, for: .normal)
            sender.tintColor = .white
            
            vc.likesVC.model.likesTracks.remove(at: indexPath.row)
            UserDefaults.standard.set(vc.likesVC.model.likesTracks, forKey: "songs")
            
            vc.likesVC.model.likesArtist.remove(at: indexPath.row)
            UserDefaults.standard.set(vc.likesVC.model.likesArtist, forKey: "names")
            
            tabBarController?.selectedIndex = 2
            
        }
    }
 //Add track to playlistLibrary
    @objc func addTrackToPlaylist(_ sender:UIButton){
        
        var alert = UIAlertController(title: "Добавить в плейлист?" ,
                                      message: "Трек будет добавлен",
                                      preferredStyle: .actionSheet)
        alert.view.tintColor = .gray
        let action = UIAlertAction(title: "ОК", style: .default) { [weak self] _ in
            
            var index = 0
            
            let vc = LibraryPlaylistVC()
            vc.selectionHandler = { [weak self] playlist in
                ApiCaller.sharedCaller.addTrackToPlaylist(track: (self?.model.albumDetails[index])!, playlist: playlist) { succsses in
                    print("adding")
                    
                }
            }
            self?.present(UINavigationController(rootViewController: vc),
                          animated: true,
                          completion: nil)
            vc.modalPresentationStyle = .overFullScreen
        }
        
        alert.addAction(action)
        present(alert, animated: true)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = PlayerViewController()
        vc.model.itemArray.append(model.albumDetails[indexPath.row].preview_url!)
        vc.model.imageView.append((model.album.images.first!.url))
        vc.model.names.append(model.albumDetails[indexPath.row].name)
        vc.model.namesTrack.append(model.albumDetails[indexPath.row].artists.first!.name)
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
            
    //MARK: Item
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
    //MARK: Group
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),heightDimension:.fractionalHeight(0.2)),subitems: [item])
            groupItem.interItemSpacing = .fixed(100)
            
            
    //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 50, bottom: 40, trailing: 20)
            
            return section
            
        case 1 :
            
    //MARK: Item
        
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.96), heightDimension: .fractionalHeight(0.13)))
            item.edgeSpacing = .init(leading: .fixed(10), top: .fixed(10), trailing: .fixed(0), bottom: .fixed(5))
    //MARK: Group
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.8)),subitems: [item])
            groupItem.interItemSpacing = .fixed(5)
            
    //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 100, leading: 0, bottom: 40, trailing: 10)
            
            return section
            
        default:
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
    //MARK:  Group
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
            
    //MARK: Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
            
            return section
        }
    }
}
