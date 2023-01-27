////
////  Category.swift
////  MusicApp
////
////  Created by Даша Волошина on 27.12.22.
////
//
import Foundation

struct Categories:Decodable{
    let categories: Category
}

struct Category:Decodable{

    let items:[ItemsCategory]
}

struct ItemsCategory:Decodable{
    let icons:[APIImage]
    let id:String
    let name:String
    init(icons: [APIImage], id: String, name: String) {
        self.icons = icons
        self.id = id
        self.name = name
    }
}


