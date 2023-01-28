//
//  SearchResultViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 5.01.23.
//

import UIKit
import SnapKit
import SafariServices

class SearchResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var model = ModelSearchResult()
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.viewController = self
        
        view.addSubview(tableView)
        tableView.backgroundView = UIVieww()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: SearchCell.id)
        tableView.frame = view.bounds
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            
            return "Альбомы"
        }
        
        if section == 1 {
            
            return "Плейлисты"
            
        }
        
        if section == 2 {
            
            return "Артисты"
        }
        if section == 3 {
            
            return "Треки"
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return model.searchAlbums.count
            
        }
        
        else if section == 1 {
            return  model.searchPlaylist.count
            
        }
        
        else if section == 2 {
            
            return  model.searchArtist.count
            
        }
        
        else if section == 3{
            
            return  model.searchTracks.count
            
        }
        
        return section
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
            cell.label.text =  model.searchAlbums[indexPath.row].name
            
            return cell
        }
        
        else if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
            cell.label.text =  model.searchPlaylist[indexPath.row].name
            
            return cell
            
        }
        
        else if indexPath.section == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
            cell.label.text =  model.searchAlbums[indexPath.row].name
            
            return cell
            
        }
        
        else if indexPath.section == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.id, for: indexPath) as! SearchCell
            cell.label.text =  model.searchTracks[indexPath.row].name
            
            return cell
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            let vc = AlbumViewController()
            vc.model.album =  model.searchAlbums[indexPath.row]
            
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
        if indexPath.section == 1 {
            let vc = PlaylistController()
            vc.model.playlist = model.searchPlaylist[indexPath.row]
            
            vc.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.section == 2 {
            let vc = SFSafariViewController(url: URL(string:  model.searchArtist[indexPath.row].external_urls["spotify"] ?? "")!)
            present(vc, animated: true)
            
        }
        
        if indexPath.section == 3 {
            let vc = PlayerViewController()
            vc.model.itemArray.append( model.searchTracks[indexPath.row].preview_url ?? "")
            vc.model.imageView.append(( model.searchTracks[indexPath.row].album?.images.first?.url)!)
            vc.model.names.append(model.searchTracks[indexPath.row].name)
            vc.model.namesTrack.append( model.searchTracks[indexPath.row].artists.first!.name)
            
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
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel!.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)!
        header.textLabel!.textColor = .white
        header.textLabel?.frame = CGRect(x: 5, y: 0, width: 200, height: 30)
    }
}
