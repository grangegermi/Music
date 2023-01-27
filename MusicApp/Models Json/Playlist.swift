//
//  Playlist.swift
//  MusicApp
//
//  Created by Даша Волошина on 19.12.22.
//

import Foundation

struct Playlist:Decodable{
    let playlists: ItemsPlaylist
}


struct CategoryDetails: Decodable {
    let playlists:ItemsPlaylist
}


struct ItemsPlaylist:Decodable{
    let items: [Item]
}

struct Item: Decodable {
    
    let  description:String
    let  id:String
    let  images:[APIImage]
    let  name:String
    
    init(description: String, id: String, images: [APIImage], name: String) {
        self.description = description
        self.id = id
        self.images = images
        self.name = name
    }
}

struct UserForPlaylist:Decodable {
    
    let display_name:String
    let id: String 
    
}
