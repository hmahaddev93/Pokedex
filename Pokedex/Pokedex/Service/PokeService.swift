//
//  
//
//  Created by Khatib Mahad H. on 8/3/21.
//

import Foundation

enum PokeAPI  {
    static let baseURL: String = "https://pokeapi.co/api/v2"
    enum EndPoints {
        static let pokemon = "/pokemon"
    }
}

protocol PokeService_Protocol {
    func storeAllPokemons(pokemons: [Pokemon])
    func fetchPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void)
}

class PokeService: PokeService_Protocol {
            
    private let httpManager: HTTPManager
    private let jsonDecoder: JSONDecoder
    private let dataManager: DataManager
    
    init(httpManager: HTTPManager = HTTPManager.shared) {
        self.httpManager = httpManager
        self.dataManager = DataManager.shared
        self.jsonDecoder = JSONDecoder()
        self.jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func storeAllPokemons(pokemons: [Pokemon]) {
        self.dataManager.storePokemons(pokemons: pokemons)
    }
    
    struct LocalPokemonsBody: Codable {
        let allPokemons: [Pokemon]
    }
    
    func fetchPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        if httpManager.isOnline {
            // when online
            fetchOnlineFirstPokemonsTo(number: 151) { result in
                switch result {
                case .success(let pokemons):
                    self.storeAllPokemons(pokemons: pokemons)
                    completion(.success(pokemons))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        else {
            // when offline
            fetchPokemonsFromLocal { result in
                switch result {
                case .success(let pokemons):
                    completion(.success(pokemons))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    private func fetchPokemonsFromLocal(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let lastSavedData = self.dataManager.fetchLocalData().last?.values else {
            completion(.success([]))
            return
        }
        
        let result = try! JSONDecoder().decode(LocalPokemonsBody.self, from: lastSavedData)
        completion(.success(result.allPokemons))
    }
        
    private func fetchOnlineFirstPokemonsTo(number: Int, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let pokemonUrlString = PokeAPI.baseURL + PokeAPI.EndPoints.pokemon
        var pokemons = [Pokemon]()
        
        let dispatchQueue = DispatchQueue(label: "pokemonQueue", qos: .background)
        let semaphore = DispatchSemaphore(value: 0)

        dispatchQueue.async {
            for pokemonId in 1...number {
                self.httpManager.get(urlString: String(format: "%@/%d", pokemonUrlString, pokemonId)) { result in
                    switch result {
                    case .success(let data):
                        guard let pokemon = try? self.jsonDecoder.decode(Pokemon.self, from: data) else {
                            print("%d pokemon data has issue", pokemonId)
                            semaphore.signal()
                            return
                        }
                        pokemons.append(pokemon)
                        print("%d pokemon fetched", pokemonId)
                        
                        // Signals that the current pokemon fetch API request has completed
                        semaphore.signal()
                        if pokemonId == number {
                            completion(.success(pokemons))
                        }
                        return
                    case .failure(let error):
                        print(error.localizedDescription)
                        semaphore.signal()
                        if pokemonId == number {
                            completion(.success(pokemons))
                        }
                        return
                    }
                }
                // Wait until the previous API request completes
                semaphore.wait()
            }
        }
    }
}

