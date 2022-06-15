//
//  NetworkCall.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 13.06.2022.
//

import Foundation
import UIKit

//URL Types
enum UrlType {
    case character
    case episode
    case location
}

//Fetch Class
class NetworkCall {
    
    static let shared = NetworkCall()
    
    private var baseCharacterURL: String = "https://rickandmortyapi.com/api/character"
    private var baseEpisodeURL: String = "https://rickandmortyapi.com/api/episode"
    private var baseLocationURL: String = "https://rickandmortyapi.com/api/location"
    
    //Create URL Method
    private func getURL(urlType: UrlType,
                        isSingleCharacter: Bool,
                        isSingleEpisode: Bool,
                        isSingleLocation: Bool,
                        id: Int? = 1,
                        page: Int? = 1) -> URL {
        
        switch urlType {
        case .character:
            return URL(string: isSingleCharacter ? baseCharacterURL + "/\(id~)" : baseCharacterURL + "?page=\(page~)")!
        case .episode:
            return URL(string: isSingleEpisode ? baseEpisodeURL + "/\(id~)" : baseEpisodeURL + "?page=\(page~)")!
        case .location:
            return URL(string: isSingleLocation ? baseLocationURL + "/\(id~)" : baseLocationURL + "?page=\(page~)")!
        }
    }
    
    //Get Data Method
    func getData<S: Codable>(urlType: UrlType,
                             isCharacter: Bool? = false,
                             isEpisode: Bool? = false,
                             isLocation: Bool? = false,
                             isCharacterEpisode: Bool? = false,
                             episodeURL: String? = "",
                             page: Int? = 1,
                             id: Int? = 1,
                             expecting: S.Type,
                             completion: @escaping (Result<S, Error>) -> Void) {
        
        guard let id = id,
              let isCharacter = isCharacter,
              let isEpisode = isEpisode,
              let isLocation = isLocation,
              let isCharacterEpisode = isCharacterEpisode else { return }
        
        //URL for dataTask
        var url: URL
        
        //Control Which Service Will Use (Episode or Character)
        if isCharacterEpisode {
            guard let episodeURL = episodeURL else {
                return
            }
            url = URL(string: episodeURL)!
        } else {
            url = getURL(urlType: urlType,
                         isSingleCharacter: isCharacter,
                         isSingleEpisode: isEpisode,
                         isSingleLocation: isLocation,
                         id: id,
                         page: page)
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
