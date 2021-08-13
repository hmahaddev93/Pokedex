//
//  PokemonType.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/11/21.
//

import Foundation

struct PokemonTypeSlot: Codable {
    let slot: Int
    let type: PokemonType
}

struct PokemonType: Codable {
    let name: String
}
