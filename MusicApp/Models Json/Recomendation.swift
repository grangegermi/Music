////
//  Recomendation.swift
//  MusicApp
//
//  Created by Даша Волошина on 19.12.22.
//

import Foundation

struct TracksRecomendation:Decodable{
    let tracks: [AudioTrack]
}

struct Tracks:Decodable {
    let album: Album?
    let artists: [Artist]
    let available_markets: [String]
    let disc_number: Int
    let duration_ms: Int
    let id: String
    let name: String
    let preview_url: String?  
    
}
