//
//  Constants.swift
//  PokeDic
//
//  Created by Mac on 2/28/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import Foundation

typealias DownloadComplete = () -> ()

struct PokemonAPI {
    static let url_Base = "https://pokeapi.co"
    static let url_Pokemon = "/api/v1/pokemon/"
    static let pokemonURL = url_Base + url_Pokemon
}
 
