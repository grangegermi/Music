//
//  MyAlbum.swift
//  MusicApp
//
//  Created by Даша Волошина on 19.12.22.
//

import Foundation

struct MyAlbum: Decodable{
    
    let items: [SavedAlbum]
    
}

struct SavedAlbum:Decodable {
    
        let added_at: String
        let album: Album
}

