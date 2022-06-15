//
//  EpisodesModel.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 14.06.2022.
//

import Foundation

//Episode Model
struct EpisodeModel: Codable {
    
    let error: String? //For getting error from service
    let id: Int?
    let name: String?
    let episode: String?
}
