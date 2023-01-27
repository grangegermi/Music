//
//  AuthResponse.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//


import Foundation

struct AuthResponse:Decodable {
    let access_token: String
    let expires_in: Int
    let refresh_token: String?
    let scope: String
    let token_type:String
}
