//
//  PlaylistDetails.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.12.22.
//

import Foundation
struct PlaylistDetails: Decodable{
    let description:String
    let followers:Followers
    let id:String
    let href:String
    let images:[APIImage]
    let name:String
    let owner:Owner
    let snapshot_id:String
    let tracks:TracksItems
}

struct TracksItems:Decodable {
    let items:[Items]
}

struct Items:Decodable{
    let track:AudioTrack
}

struct Owner:Decodable{
    let href:String
    let display_name:String
    let id:String
}
struct Followers:Decodable{
    let total:Int
}
