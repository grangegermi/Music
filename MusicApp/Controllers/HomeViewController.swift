//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import SnapKit
import SDWebImage


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var albums:[Album] = []
    var playlist:[Item] = []
    var tracksRecomendation:[Tracks] = []
    var category:[ItemsCategory] = []
    
    var track = AudioTrack(album: Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: []), artists: [], available_markets: [], disc_number: 0, duration_ms: 0, explicit: true, external_urls: ["":""], id: "", name: "", preview_url: "")

    var trackRecomendation = Tracks(album: Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: []), artists: [], available_markets: [], disc_number: 0, duration_ms: 0, id: "", name: "", preview_url: "")
    
    var collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        navigationController?.navigationBar.topItem?.title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(buttonTap)),
                                               UIBarButtonItem(image: UIImage(systemName: "bell"),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(buttonTap))]
        regitrationCell()

        getNeetworkData()
        collectionView.reloadData()
    }
    
    func getNeetworkData() {
       let group = DispatchGroup()
        group.enter()
        ApiCaller.sharedCaller.getNewReleases(completion: {[weak self] result in
      
                switch result {
                case.success(let model):
                    self?.albums.append(contentsOf: model.albums.items.compactMap({$0}))
//                    print(self.albums.count)
                case.failure(let error):
                    if error != nil {
                        self?.collectionView.emptyView(title:"Ошибка", message: "Перезагрузите приложение")
                    }
                    print(error)
                    
                default: break
        }
            group.leave()
        })
        group.enter()

        ApiCaller.sharedCaller.getFeaturedPlaylists { [weak self] result in
            
            switch result {
            case .success(let model):
                self?.playlist.append(contentsOf: model.playlists.items.compactMap({$0}))
           
            case .failure( let error):
                
                if error != nil {
                    self?.collectionView.emptyView(title:"Ошибка", message: "Перезагрузите приложение")
                }
                
                print(error)
                
            default: break
            }
            group.leave()
        }
        
        group.enter()
        ApiCaller.sharedCaller.getRecommendations{ [weak self] result in
            
            switch result{
            case .success(let model):
                self?.tracksRecomendation.append(contentsOf: model.tracks.filter{$0.preview_url != nil}.compactMap({$0}))
            case .failure(let error):
                
                if error != nil {
                    self?.collectionView.emptyView(title:"Ошибка", message: "Перезагрузите приложение")
                }
                
                print(error)
            default: break
        }
            
            group.leave()

    }
        
        ApiCaller.sharedCaller.getCategory { [weak self] result in
            
            switch result{
            case .success(let model):
                self?.category.append(contentsOf: model.categories.items.compactMap({$0}))
            case.failure(let error):
                print(error)
            }
        }
        group.notify(queue: .main){
            
            self.collectionView.reloadData()
        }
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
            
            return albums.count
        }
        
        if section == 1 {
            
            return playlist.count
        }
        
        if section == 2 {
            
            return tracksRecomendation.count
        }
        
        return section
    }
    
    //MARK: - Create Cell
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = UICollectionViewCell()
        
        //MARK: -  First
        if indexPath.section == 0 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCell.id, for: indexPath) as! AlbumCell
        
           
            cell.nameAlbums.text = albums[indexPath.row].name
           
            cell.imageView.sd_setImage(with: albums[indexPath.row].images.first?.url)
            cell.nameArtist.text = albums[indexPath.row].artists.first?.name
            

            return cell
        }
        //MARK: -  Second
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCell.id, for: indexPath) as! TrackCell
    
            cell.nameArtist.text = playlist[indexPath.row].name
            cell.imageView.sd_setImage(with: playlist[indexPath.row].images.first?.url)
            cell.nameDescription.text = playlist[indexPath.row].description

            return  cell
        }
        //MARK: -  Third
        if indexPath.section == 2 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:RecomendationCell.id, for: indexPath) as! RecomendationCell
            cell.namePlaylist.text = tracksRecomendation[indexPath.row].name
            cell.nameArtist.text = tracksRecomendation[indexPath.row].artists.first?.name
            cell.imageView.sd_setImage(with: tracksRecomendation[indexPath.row].album?.images.first?.url)
            
            return cell
        }
        return cell
    }
    
 
    //MARK: - Create Header
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var header = UICollectionReusableView()
        
        if indexPath.section == 0 {
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier:HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
            header.label.text = "New Releases"
            header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
            return header
        }
        
        if indexPath.section == 1 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
            header.label.text = "Playlists for you"
            header.label.font = UIFont(name: "Noto Sans Kannada Bold", size: 24)
            
            return header
        }
        
        if indexPath.section == 2 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: HeaderCollectionViewCell.kind, withReuseIdentifier: HeaderCollectionViewCell.id, for: indexPath) as! HeaderCollectionViewCell
            header.label.text = "Recommended tracks"
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
            //MARK: -  item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(0))
            //MARK: -  group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.2)),subitems: [item])
            
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 40, trailing: 20)
            
            //MARK: -  Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
            
        case 1 :
                    
            //MARK: -  item
            
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1)))
            item.edgeSpacing = .init(leading: .fixed(5), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(5))
            //MARK: -  group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.3)),subitems: [item])
            
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem )
            section.orthogonalScrollingBehavior = .paging
            section.contentInsets = .init(top: 0, leading: 0, bottom: 120, trailing: 20)
            
            //MARK: -  Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
            return section
            
        case 2 :
            //MARK: -  Item
                        
            let item = NSCollectionLayoutItem(layoutSize: (NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.45), heightDimension: .fractionalHeight(1))))
            item.edgeSpacing = .init(leading: .flexible(5), top:.flexible(0), trailing: .flexible(5), bottom: .flexible(0))
            
            //MARK: - Group
            
            let groupItem = NSCollectionLayoutGroup.horizontal(layoutSize:NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),heightDimension: .fractionalHeight(0.45)),subitems: [item])
            //        groupItem.interItemSpacing = .flexible(10)
            //        groupItem.contentInsets = .init(top: 5, leading: 10, bottom: 0, trailing: 0)
            
            //MARK: -  Section
            
            let section = NSCollectionLayoutSection(group: groupItem)
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 10, leading:0, bottom: 80, trailing: 0 )
            
            //MARK: - Header
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,elementKind: HeaderCollectionViewCell.kind, alignment: .top)
            section.boundarySupplementaryItems = [header]
            
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let vc = AlbumViewController()
            vc.album = albums[indexPath.row].self
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
  
        }
        if indexPath.section == 1 {
            let vc = PlaylistController()
            navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            vc.playlist = playlist[indexPath.row].self
        }
        if indexPath.section == 2 {
    
            let vc = PlayerViewController()
            navigationController?.pushViewController(vc, animated: true)
            vc.modalPresentationStyle = .fullScreen
            vc.trackItems.append(tracksRecomendation[indexPath.row].preview_url ?? "")
            vc.image.append((tracksRecomendation[indexPath.row].album?.images.first?.url)!)
            vc.names.append(tracksRecomendation[indexPath.row].name)
//          vc.trackRecomendation = tracksRecomendation[indexPath.row].self
            
           
        }
    }
  
}

extension UICollectionView {
    
    func emptyView(title:String, message:String) {
        
        
        var emptyView = UIView()
        var titleLabel = UILabel()
        var messageLabel = UILabel()
      
        emptyView.frame = CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.backgroundColor = .gray
     
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.top.equalTo(emptyView.snp.top).inset(120)
            
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.top.equalTo(emptyView.snp.top).inset(200)
            
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Noto Sans Kannada Bold", size: 18)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        messageLabel.textColor = .white
        messageLabel .textAlignment = .center
        
        titleLabel.text = title
        messageLabel.text = message

        self.backgroundView = emptyView
       
    }
    
    func restore() {
        self.backgroundView = nil
     
    }
}
