//
//  PokemonMove.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/11/21.
//

import Foundation
import CoreData

struct PokemonMoveSetting: Codable {
    let move: PokemonMove
}

struct PokemonMove: Codable {
    let name: String
}
