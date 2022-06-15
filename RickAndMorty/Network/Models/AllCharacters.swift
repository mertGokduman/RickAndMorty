//
//  AllCharacters.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 13.06.2022.
//

import Foundation

//All Character Model
struct AllCharacters: Codable {
    
    let error: String? //For getting error from service
    let info: Info?
    let results: [SingleCharacter]?
}

struct Info: Codable {
    
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct SingleCharacter: Codable {
    
    let error: String? //For getting error from service
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin: OriginLocation?
    let location: OriginLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct OriginLocation: Codable {
    
    let name: String?
    let url: String?
}
