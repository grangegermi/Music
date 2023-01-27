//
//  AlbumDatail.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import Foundation
struct AlbumDetail:Decodable{
    
    var album_type: String
    var artists: [Artist]
    var available_markets: [String]
    var external_urls: [String: String]
    var id: String
    var images: [APIImage]
    var label: String
    var name: String
    var tracks: TracksResponse
}

struct TracksResponse: Decodable {
    
    var items: [AudioTrack]
    
}

struct AudioTrack: Decodable{
    var album: Album?
    var artists: [Artist]
    var available_markets: [String]
    var disc_number: Int
    var duration_ms: TimeInterval
    var explicit: Bool
    var external_urls: [String: String]
    var id: String
    var name: String
    var preview_url:String?
}
