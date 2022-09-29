//
//  Music.swift
//  MusicApp
//
//  Created by Gilles Sagot on 22/09/2022.
//

import Foundation

struct SearchResult: Codable {
    
    let data: [Track]
    
}

struct Track: Codable {
    
    let id: Int
    let title: String
    let link: String
    let artist: Artist
    let album: Album
    let preview: String
    
}

struct Album: Codable {
    
    let id: Int
    let title: String
    let cover: String
    
}

struct Artist: Codable {
    
    let id: Int
    let name: String
    let link: String
    let picture: String
    
}
