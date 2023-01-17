//
//  User Playlist.swift
//  MusicApp
//
//  Created by Даша Волошина on 16.01.23.
//

import Foundation
struct LibraryPlaylist: Decodable{
    
    let items:[Item]
}

struct UserPlaylist: Decodable{
    
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: OwnerUser
    
}
struct OwnerUser: Decodable {
    let display_name: String
    let external_urls: [String:String]
    let id:String
    
}
     
