//
//  PlaylistLibraryViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 16.01.23.
//

import UIKit
import SnapKit
import SDWebImage

class LibraryPlaylistVC: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var playlist: [Item] = []
    
    var selectionHandler: ((Item) -> Void)?
   
    
    let page = UIPageControl()
    
    let tableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
   
        view.addSubview(tableView)
     
        tableView.frame = view.bounds
        tableView.backgroundColor = .darkGray
        tableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.id)
        tableView.delegate = self
        tableView.dataSource = self

        getData()

    }
    
    func getData () {
        let group = DispatchGroup()
        group.enter()
        ApiCaller.sharedCaller.getPlaylistUser {[weak self] result in

            switch result {
            case .success(let userPlaylist):

                self?.playlist = userPlaylist.self
                print(self?.playlist.count)

            case .failure(let error):

                print(error)
            }
            group.leave()
        }
        group.notify(queue: .main){ [weak self] in
          
            self?.tableView.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if playlist.count == 0 {
            
            tableView.emptyView(title: "Создай свой первый плэйлист", message: "Нажми на  +  , чтобы добавить новый")
        } else{
            
            tableView.restore()
            return playlist.count
        }
        return playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.id, for: indexPath) as! LibraryCell
       
        cell.nameArtist.text = playlist[indexPath.row].name
        cell.nameSong.text = playlist[indexPath.row].description
        cell.viewImage.sd_setImage(with: playlist[indexPath.row].images.first?.url)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlists = playlist[indexPath.row]
        guard selectionHandler == nil else {
            selectionHandler?(playlists)
           dismiss(animated: true, completion: nil)
            return
        }
        
        let vc = PlaylistController()
        vc.playlist = playlist[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .systemGray4
       
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            let group = DispatchGroup()
                if editingStyle == .delete {
                    print("Deleted")
          
                    group.enter()
              ApiCaller.sharedCaller.deletePlaylist(name: self.playlist[indexPath.row].name) { succsses in
                 
                  print("deleted playlist")
              }
          group.leave()
          }
        group.notify(queue: .main) {
            print("aa")
            self.playlist.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
       
      }
}

extension UITableView{
    
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
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
