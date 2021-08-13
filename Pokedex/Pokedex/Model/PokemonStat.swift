//
//  PokemonStat.swift
//  Pokedex
//
//  Created by Khateeb Mahad H. on 8/11/21.
//

import Foundation

struct PokemonStatSetting: Codable {
    let baseStat: Int
    let effort: Int
    let stat: PokemonStat
}

struct PokemonStat: Codable {
    let name: String
}
