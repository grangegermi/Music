//
//  LibraryViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit

class LibraryViewController: UIViewController {
    
 
    var track = Tracks(album: Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: []), artists: [], available_markets: [], disc_number: 0, duration_ms: 0, id: "", name: "", preview_url: "")
    override func loadView() {
        super.loadView()
        view = UIVieww()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        navigationController?.navigationBar.topItem?.title = "Library"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        ApiCaller.sharedCaller.getRecommendationsTrack(track: track) { result in
            
        }
        
     
    }
   
 
}


   


