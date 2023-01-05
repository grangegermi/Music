//
//  TrackViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import UIKit

class TrackViewController: UIViewController {
    var track = Tracks(album: Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: []), artists: [], available_markets: [], disc_number: 0, duration_ms: 0, id: "", name: "", preview_url: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        ApiCaller.sharedCaller.getRecommendationsTrack(track: track) { result in
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
