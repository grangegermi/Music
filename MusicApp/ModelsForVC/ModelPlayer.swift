//
//  File.swift
//  MusicApp
//
//  Created by Даша Волошина on 26.01.23.
//

import Foundation

class ModelPlayer {
    
    weak var viewController:PlayerViewController?
    
    var itemArray:[String] = [] 
    var imageView: [URL] = []
    var names:[String] = []
    var namesTrack:[String] = []
}
