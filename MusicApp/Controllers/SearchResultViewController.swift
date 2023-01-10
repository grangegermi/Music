//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 5.01.23.
//

import UIKit
import SnapKit
import SafariServices

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    let tableView = UITableView()
    var searchAlbums:[Album] = []
    var searchPlaylist:[Item] = []
    var searchArtist:[Artist] = []
    var searchTracks:[AudioTrack] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.backgroundView = UIVieww()
      
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.id)
       
        tableView.frame = view.bounds
        tableView.reloadData()
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
             return "Albums"
        }
        
        if section == 1 {
           
            return "Playlist"
            
        }
        
        if section == 2 {
            
            return "Artist"
        }
        if section == 3 {
            
            return "Tracks"
        }
        
        return String()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return searchAlbums.count
            
        }
        
        else if section == 1 {
            return searchPlaylist.count
            
        }
        
        else if section == 2 {
            
            return searchArtist.count
            
        }
        
        else if section == 3{
            
            return searchTracks.count
            
        }
        
        return section
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
            cell.label.text = searchAlbums[indexPath.row].name
            
            return cell
        }
        
        else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
            cell.label.text = searchPlaylist[indexPath.row].name
                
            return cell
            
        }
        
        else if indexPath.section == 2 {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
           cell.label.text = searchAlbums[indexPath.row].name
                    
           return cell
            
        }
        
        
         else if indexPath.section == 3 {
    
             let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
             cell.label.text = searchTracks[indexPath.row].name
             
             return cell
             
        }

        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let vc = AlbumViewController()
            vc.album = searchAlbums[indexPath.row]
        
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.section == 1 {
            let vc = PlaylistController()
            vc.playlist = searchPlaylist[indexPath.row]
            
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 2 {
            let vc = SFSafariViewController(url: URL(string: searchArtist[indexPath.row].external_urls["spotify"] ?? "")!)
            present(vc, animated: true)

        }
        
        if indexPath.section == 3 {
            let vc = PlayerViewController()
            vc.trackItems.append(searchTracks[indexPath.row].preview_url ?? "")
            vc.image.append((searchTracks[indexPath.row].album?.images.first?.url)!)
            vc.names.append(searchTracks[indexPath.row].name)
            
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)

        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundView = UIVieww()
       
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        var title = UILabel()
            title.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)!
            title.textColor = .white

            let header = view as! UITableViewHeaderFooterView
            header.textLabel!.font = title.font
            header.textLabel!.textColor = title.textColor
            
    }

}
