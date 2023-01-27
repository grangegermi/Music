//
//  SearchResult.swift
//  MusicApp
//
//  Created by Даша Волошина on 6.01.23.
//

import Foundation

struct Search:Decodable {
    let albums: SearchAlbum
    let artists:SearchArtist
    let playlists:SearchPlaylists
    let tracks:TracksSeacrh
}

struct SearchAlbum:Decodable {
    
    let items:[Album]
}

struct SearchArtist:Decodable {
    let items:[Artist]
    let limit: Int
}

struct SearchPlaylists:Decodable{
    let items:[Item]
}

struct TracksSeacrh:Decodable{
    let items:[AudioTrack]
}




