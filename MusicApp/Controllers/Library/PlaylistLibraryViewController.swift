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

    var model = PlaylistLibrary()
    var selectionHandler: ((Item) -> Void)?
  
    let tableView = UITableView()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.viewController = self
        view.addSubview(tableView)
     
        tableView.frame = view.bounds
        tableView.backgroundColor = .darkGray
        tableView.register(LibraryCell.self, forCellReuseIdentifier: LibraryCell.id)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        print(model.playlist.count)
        
        model.getData()

    }
//MARK: - DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.playlist.count == 0 {
            
            tableView.emptyView(title: "Создай свой первый плэйлист", message: "Зайдите в раздел Библиотека и  нажми на  +  , чтобы создать новый, или просто нажмите на + , если Вы уже здесь")
        } else {
            
            tableView.restore()
    
            return model.playlist.count
        }
        return model.playlist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: LibraryCell.id, for: indexPath) as! LibraryCell
       
        cell.nameArtist.text = model.playlist[indexPath.row].name
        cell.nameSong.text = model.playlist[indexPath.row].description
        cell.viewImage.sd_setImage(with: model.playlist[indexPath.row].images.first?.url)
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playlists = model.playlist[indexPath.row]
        guard selectionHandler == nil else {
            selectionHandler?(playlists)
           dismiss(animated: true, completion: nil)
            return
        }
        
        let vc = PlaylistController()
        vc.model.playlist = model.playlist[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .systemGray
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
                if editingStyle == .delete {
                    print("Deleted")
          
               
        ApiCaller.sharedCaller.deletePlaylist(name:self.model.playlist[indexPath.row].name) { succsses in
                  print("deleted playlist")
              }
          }
            print("aa")
        
            self.model.playlist.remove(at: indexPath.row)
            tableView.reloadData()
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
      }
}


