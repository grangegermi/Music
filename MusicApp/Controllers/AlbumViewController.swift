//
//  AlbumViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 1.01.23.
//

import UIKit
import SDWebImage
import SnapKit


class AlbumViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var album = Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: [])

    var albumDetails:[AudioTrack] = []
    var sortedAlbum:[AudioTrack] = []
    
   
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return AlbumViewController.createSectionLayout(section: sectionIndex)
        }

    )
    var track = AudioTrack(album: Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: []), artists: [], available_markets: [], disc_number: 0, duration_ms: 0, explicit: true, external_urls: ["":""], id: "", name: "", preview_url: "")
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
        getDataNetwork()
    }
    
    func getDataNetwork() {
        var group =  DispatchGroup()
        group.enter()
        ApiCaller.sharedCaller.getAlbumsDetail(album: album) { [weak self] result  in
            switch result{
            case.success(let model):
              
                self?.albumDetails.append(contentsOf: model.tracks.items.filter{$0.preview_url != nil}.compactMap({$0}))
                
                    if self?.albumDetails.isEmpty == true {
                    var vc = UIAlertController(title: "Message", message: "Album not available", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel)
                    vc.addAction(action)
                        self?.present(vc, animated: true)
                        
                }
                
                print(self?.albumDetails)
      
            case.failure(let error):
                print(error)
            }
            group.leave()
        }
      
        group.notify(queue: .main){ [weak self] in
            print("all")
            self?.collectionView.reloadData()
        }
       
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
  
            return 2

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        }
        
        if section == 1 {
        
            return albumDetails.count
        }

        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCellDetails.id, for: indexPath) as! AlbumCellDetails
            
            cell.label.text = album.name
            cell.imageView.sd_setImage(with: album.images.first?.url)
            cell.labelDescription.text = album.release_date
            return cell
        }
        
        if indexPath.section == 1 {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCellDetailsTraks.id, for: indexPath) as! AlbumCellDetailsTraks
           
          
                cell.labelNameArtist.text = albumDetails[indexPath.row].artists.first?.name
                cell.labelNameTrack.text = albumDetails[indexPath.row].name
                cell.labelNumber.text = "\((indexPath.row) + 1)"
                
                
                let formatter = DateComponentsFormatter()
                formatter.allowedUnits = [.minute, .second]
                formatter.unitsStyle = .positional
                cell.labelTime.text = formatter.string(from: TimeInterval(albumDetails[indexPath.row].duration_ms))
                
       
            return cell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
//        let vc = PlayerViewController()
//        print("selected")
//        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .fullScreen
////        vc.items = albumDetails.self
//        vc.trackItems.append(albumDetails[indexPath.row].preview_url!)
//        vc.image.append((album.images.first!.url))
//        vc.names.append(albumDetails[indexPath.row].name)
        let vc = ViewController()
        vc.itemArray.append(albumDetails[indexPath.row].preview_url!)
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
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            
            //MARK: -  group
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),heightDimension:.fractionalHeight(0.2)),subitems: [item])
            groupItem.interItemSpacing = .fixed(100)
            
            
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 50, bottom: 40, trailing: 20)

            return section
            
        case 1 :
            
            //MARK: -  item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.96), heightDimension: .fractionalHeight(0.13)))
            item.edgeSpacing = .init(leading: .fixed(10), top: .fixed(10), trailing: .fixed(0), bottom: .fixed(5))
            //MARK: -  group
            
            let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.8)),subitems: [item])
            groupItem.interItemSpacing = .fixed(5)
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 100, leading: 0, bottom: 40, trailing: 10)
            
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
}
