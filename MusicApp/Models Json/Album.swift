//
//  Album.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

struct NewReleasesResponse: Decodable {
    let albums: AlbumsResponse
}

struct AlbumsResponse: Decodable{
    let items: [Album]
  
}

struct Album: Decodable {
    let album_type: String
    let available_markets: [String]
    let id: String
    var images: [APIImage]
    let name: String
    let release_date: String
    let total_tracks: Int
    let artists: [Artist]
    init(album_type: String, available_markets: [String], id: String, images: [APIImage], name: String, release_date: String, total_tracks: Int, artists: [Artist]) {
        self.album_type = album_type
        self.available_markets = available_markets
        self.id = id
        self.images = images
        self.name = name
        self.release_date = release_date
        self.total_tracks = total_tracks
        self.artists = artists
    }
}

struct Artist: Decodable {
    let id: String
    let name: String
    let type: String
//    let images: [PIImage]?
    let external_urls: [String: String]
}
