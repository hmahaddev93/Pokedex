//
//
//  Created by Khatib Mahad H. on 7/19/21.
//

import Foundation

class PokemonViewModel {
    // MARK: - Initialization
    init(model: [Pokemon]? = nil) {
        if let inputModel = model {
            pokemons = inputModel
        }
    }
    var pokemons = [Pokemon]()
    var filtered = [Pokemon]()
    let pokeService = PokeService()
}

extension PokemonViewModel {
    
    func fetchFirst151Pokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        
        pokeService.fetchPokemons { result in
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.filtered = pokemons
                completion(.success(pokemons))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func filterBy(query: String) {
        filtered = pokemons.filter{$0.name.lowercased().contains(query.lowercased())}
    }
    
    func sortBy(mode: SortMode) {
        switch mode {
        case .number:
            self.filtered = filtered.sorted {
                $0.id < $1.id
            }
        case .name:
            self.filtered = filtered.sorted {
                $0.name < $1.name
            }
        case .type:
            self.filtered = filtered.sorted {
                $0.types.first!.type.name < $1.types.first!.type.name
            }
        }
    }
}
