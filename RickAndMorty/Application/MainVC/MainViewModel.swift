//
//  MainViewModel.swift
//  RickAndMorty
//
//  Created by Mert Gökduman on 12.06.2022.
//

import Foundation

protocol DataReachedProtocol {
    func dataReached(data: [SingleCharacter])
    func errorReached(data: AllCharacters)
}

class MainViewModel: BaseViewModel {
    
    private let delegate : DataReachedProtocol
    private var page: Int = 1
    var allCaracters: [SingleCharacter] = []
    
    init(delegate: DataReachedProtocol) {
        self.delegate = delegate
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func getCharacters(isPagination: Bool) {
        
        if isPagination {
            page += 1
        }
        
        NetworkCall.shared.getData(urlType: .character,
                                   isCharacter: false,
                                   page: page,
                                   expecting: AllCharacters.self) { result in
            switch result {
            case .success(let result):
                if result.error == nil {
                    guard let result = result.results else { return }
                    self.allCaracters.append(contentsOf: result)
                    self.delegate.dataReached(data: self.allCaracters)
                } else {
                    self.delegate.errorReached(data: result)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
