//
//  DetailsViewModel.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 12.06.2022.
//

import Foundation

protocol CharacterDataReached {
    func dataReached(data: SingleCharacter)
    func episodeDataReached(data: [String])
    func errorReached(data: String?)
}

class DetailsViewModel: BaseViewModel {
    
    var delegate : CharacterDataReached = DetailsViewController()
    var id: Int? = 2
    var character: SingleCharacter?
    var episodes: [EpisodeModel] = []
    
    func getCharacterDetail() {
        
        guard let id = id else {
            return
        }

        NetworkCall.shared.getData(urlType: .character,
                                   isCharacter: true,
                                   id: id,
                                   expecting: SingleCharacter.self) { result in
            switch result {
            case .success(let character):
                if character.error == nil {
                    self.character = character
                    self.delegate.dataReached(data: character)
                } else {
                    self.delegate.errorReached(data: character.error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getEpisodes(for episodes: [String]) {
    
        for item in episodes {
            NetworkCall.shared.getData(urlType: .location,
                                       isCharacterEpisode: true,
                                       episodeURL: item,
                                       expecting: EpisodeModel.self) { result in
                switch result {
                case .success(let episode):
                    if episode.error == nil {
                        self.episodes.append(episode)
                        self.delegate.episodeDataReached(data: episodes)
                    } else {
                        self.delegate.errorReached(data: episode.error)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
