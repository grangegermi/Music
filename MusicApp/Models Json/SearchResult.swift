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

//MARK: - Albums
struct SearchAlbum:Decodable {
    
    let items:[Album]
}

//MARK: - Artist

struct SearchArtist:Decodable {
    let items:[Artist]
    let limit: Int
}

//MARK: - Playlist
struct SearchPlaylists:Decodable{
    let items:[Item]
}


struct TracksSeacrh:Decodable{
    let items:[AudioTrack]
}




