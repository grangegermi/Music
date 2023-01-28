//
//  UserProfile.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import Foundation

struct User:Decodable {
    
    var country: String
    var display_name: String
    var email: String
    var id: String
    var product: String
    var images: [APIImage]
}

struct APIImage: Decodable {
    var url:URL
}
