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
    var model = LibraryLikes()
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.model.viewController = self
        view.addSubview(tableView)
        tableView.backgroundColor = .darkGray
        tableView.register( LikeCell.self, forCellReuseIdentifier: LikeCell.id)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.separatorStyle = .singleLine
    
        model.likesTracks = UserDefaults.standard.stringArray(forKey: "names") ?? [""]
        model.likesArtist = UserDefaults.standard.stringArray(forKey: "songs") ?? [""]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
//MARK: - Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.likesTracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier:  LikeCell.id, for: indexPath) as! LikeCell
        
        
        cell.labelNameTrack.text = model.likesTracks[indexPath.row]
        cell.labelNameArtist.text = model.likesArtist[indexPath.row]
        cell.labelNumber.text = "\(indexPath.row + 1)"
        
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
            
            self.model.likesArtist.remove(at: indexPath.row)
           UserDefaults.standard.removeObject(forKey: "songs")

            self.model.likesTracks.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: "names")

            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
            
        }
    }
}
