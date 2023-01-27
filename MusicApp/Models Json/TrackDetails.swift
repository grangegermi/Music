//
//  TrackDetails.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import Foundation

struct TrackDetails:Decodable {
    let album:Album
    let artists:Artist
    let id:String
    let name:String
    
}
