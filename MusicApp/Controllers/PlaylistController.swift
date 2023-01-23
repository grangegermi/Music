//
//  PlaylistController.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import UIKit

class PlaylistController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    var playlist = Item(description: "", id: "", images: [], name: "")
    var playlistDetails:[Items] = []
 
    var collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
                return PlaylistController.createSectionLayout(section: sectionIndex)
            }
        )
        
  
        override func viewDidLoad() {
            super.viewDidLoad()

            collectionView.register(PlaylistCell.self, forCellWithReuseIdentifier: PlaylistCell.id)
            collectionView.register(PlaylistTrackCellDetails.self, forCellWithReuseIdentifier: PlaylistTrackCellDetails.id)
            
            view.addSubview(collectionView)
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.backgroundView = UIVieww()
            collectionView.snp.makeConstraints { make in
                
                make.top.equalTo(view.snp.top)
                make.bottom.equalTo(view.snp.bottom)
                make.left.equalTo(view.snp.left)
                make.right.equalTo(view.snp.right)
            }

            networkData ()

        }

        func networkData () {
            
            let group = DispatchGroup()
            
            group.enter()
       
                ApiCaller.sharedCaller.getPlaylists(playlist: self.playlist) { [weak self] result in
            
                    switch result {
                    case .success(let model):
                        
                        self?.playlistDetails.append(contentsOf: model.tracks.items.filter{$0.track.preview_url != nil}.compactMap({$0}))
                        if self?.playlistDetails.isEmpty == true {
                        var vc = UIAlertController(title: "Message", message: "Playlist not available", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok", style: .cancel)
                        vc.addAction(action)
                            self?.present(vc, animated: true)
                            
                    }
                        
                    case.failure(let error):
                        print(error)
                    }
                    group.leave()
                }
           
            group.notify(queue: .main){
                self.collectionView.reloadData()
            }
    }
        
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            
            return 2
            
        }
        
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
           
            
            if section == 0 {

                return 1
            }

            if section == 1 {
             
             
                return playlistDetails.count
            }
             return section
        }
        
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
            let cell = UICollectionViewCell()
            
            if indexPath.section == 0 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistCell.id, for: indexPath) as! PlaylistCell
               
                cell.label.text = playlist.name
                cell.imageView.sd_setImage(with: playlist.images.first?.url)
//                cell.labelDescription.text = playlist.description
                cell.button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
                
                
                
                return cell
                
            }
            if indexPath.section == 1 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistTrackCellDetails.id, for:indexPath) as! PlaylistTrackCellDetails
                

                cell.labelNameTrack.text = playlistDetails[indexPath.row].track.name
                cell.labelNameArtist.text = playlistDetails[indexPath.row].track.artists.first?.name
                cell.imageView.sd_setImage(with: (playlistDetails[indexPath.row].track.album?.images.first?.url))

                return cell
            }
         
             return cell
        }

    
    @objc func buttonTap(_ sender:UIButton){
        print("tap")
//        let vc = PlayerViewController()
//
//        navigationController?.pushViewController(vc, animated: true)
//        vc.modalPresentationStyle = .fullScreen
//        vc.trackItems.append(contentsOf: playlistDetails.compactMap({$0.track.preview_url ?? ""}))
//        //        vc.items = playlistDetails.self
//        vc.image.append(contentsOf: playlistDetails.compactMap({$0.track.album?.images.first?.url}))
//        vc.names.append(contentsOf: playlistDetails.compactMap({$0.track.name}))
        let vc = PlayerViewController()
        vc.itemArray.append(contentsOf:  playlistDetails.compactMap({$0.track.preview_url!}))
        vc.imageView.append(contentsOf:  playlistDetails.compactMap({$0.track.album?.images.first?.url}))
        vc.names.append(contentsOf:      playlistDetails.compactMap({$0.track.name}))
        vc.namesTrack.append(contentsOf: playlistDetails.compactMap({$0.track.artists.first?.name}))
      
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
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                //MARK: -  group
                
                let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),heightDimension:.fractionalHeight(0.3)),subitems: [item])
                groupItem.interItemSpacing = .fixed(100)
                
                
                //MARK: -  Section
                
                let section = NSCollectionLayoutSection(group: groupItem )
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = .init(top: 0, leading: 50, bottom: 20, trailing: 20)

                return section
       
            case 1:
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
                item.contentInsets = .init(top:10, leading: 5, bottom: 100, trailing: 5)
//                item.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
//                item.edgeSpacing = .init(leading:.fixed(5) , top: .fixed(0), trailing: .fixed(0), bottom: .fixed(5))
                
                //MARK: -  group
                
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [item])
  
                
                let groupItem = NSCollectionLayoutGroup.vertical(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.8)),subitems: [horizontalGroup])
                groupItem.contentInsets = .init(top: 5, leading: 0, bottom: 20, trailing: 0)
                
                //MARK: -  Section
                
                let section = NSCollectionLayoutSection(group: groupItem )
                section.orthogonalScrollingBehavior = .paging
//                section.contentInsets = .init(top: 100, leading: 0, bottom: 40, trailing: 0)
            
                return section
                
            default:
                
                let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
                item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
                //MARK: -  group
                
                let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
                
                //MARK: -  Section
                
                let section = NSCollectionLayoutSection(group: groupItem )
                section.orthogonalScrollingBehavior = .paging
                section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
          
                return section
                
            }
            
        }
    }


