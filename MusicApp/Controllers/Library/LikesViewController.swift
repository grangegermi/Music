//
//  LikesViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 16.01.23.
//
import UIKit
import SDWebImage


class LibraryLikeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var index = 0
    var likesTracks:[String] = []
    var likesSong:[String] = []
    //    var likesImages:[URL] = []
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.backgroundColor = .darkGray
        //        tableView.backgroundView = UIVieww()
        tableView.register( LikeCell.self, forCellReuseIdentifier: LikeCell.id)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
        
        
            
        likesTracks = UserDefaults.standard.stringArray(forKey: "names") ?? [""]
        likesSong = UserDefaults.standard.stringArray(forKey: "songs") ?? [""]
          
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likesTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  LikeCell.id, for: indexPath) as! LikeCell
        
        
        cell.labelNameTrack.text = likesTracks[indexPath.row]
        cell.labelNameArtist.text = likesSong[indexPath.row]
        cell.labelNumber.text = "\(indexPath.row + 1)"
        //        cell.viewImage.sd_setImage(with: URL(string: likesSong[indexPath.row])!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .systemGray
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
 
        if editingStyle == .delete {
            print("Deleted")
            
            self.likesSong.remove(at: indexPath.row)
//            UserDefaults.standard.set(likesSong, forKey: "songs")
//           UserDefaults.standard.removeObject(forKey: "songs")
            UserDefaults.standard.set(likesSong, forKey: "songs")
            
            
            self.likesTracks.remove(at: indexPath.row)
            UserDefaults.standard.set(likesSong, forKey: "names")
            
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            
        }
        
    }
}
