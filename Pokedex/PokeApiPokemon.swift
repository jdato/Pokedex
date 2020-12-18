//
//  Pokemon.swift
//  Pokedex
//
//  Created by Johannes Dato on 17.12.20.
//

import Foundation

struct PokeApiResponse: Codable {
    let results: [PokeApiPokemon]
}

struct PokeApiPokemon: Codable {
    let name: String
    let url: String
}

struct PokemonApiData: Codable {
    let id: Int
    let types: [PokeApiPokemonTypeEntry]
}

struct PokeApiPokemonType: Codable {
    let name: String
    let url: String
}

struct PokeApiPokemonTypeEntry: Codable {
    let slot: Int
    let type: PokeApiPokemonType
}
