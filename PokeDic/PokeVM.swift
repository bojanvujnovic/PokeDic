//
//  PokeVM.swift
//  PokeDic
//
//  Created by Mac on 2/24/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import UIKit
import Alamofire

class PokeVM {
    
    fileprivate var pokemon: Pokemon!
    
    var image: UIImage? {        
        if let pokeImage = UIImage(named: "\(pokeID)") {
            return pokeImage }
        else {    return nil       }
    }
    
    var name: String {
        get {
            return pokemon.name.capitalized }
        set {
            pokemon.name = newValue
        }
    }
    
    var pokeID: Int {
        return pokemon.pokeID
    }
    
    var weight: String {
        get {
            return pokemon.weight }
        set {
            pokemon.weight = newValue
        }
    }
    
    var height: String {
        get {
            return pokemon.height }
        set {
            pokemon.height = newValue
        }
    }
    var attack: String {
        get {
            return pokemon.attack }
        set {
            pokemon.attack = newValue
        }
    }
    var defense: String {
        get {
            return pokemon.defense }
        set {
            pokemon.defense  = newValue
        }
    }
    

    var description: String {
        get {
            return pokemon.description }
        set {
            pokemon.description   = newValue
        }
    }
    

    var pokemonURL: String {
        return pokemon.pokemonURL
    }
    
    init(pokemon: Pokemon) {        
        self.pokemon = pokemon
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete)  {
        Alamofire.request(pokemonURL, method: HTTPMethod.get).responseJSON { [unowned self] (response) in
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict[PokeDict.weight] as? String {
                    self.weight = weight
                }
                if let height = dict[PokeDict.height] as? String {
                    self.height = height
                }
                if let attack = dict[PokeDict.attack] as? Int {
                    self.attack = "\(attack)"
                }
                if let defense = dict[PokeDict.defense] as? Int {
                    self.defense = "\(defense)"
                }
               
            }
             completed()
        }
    }
    
}
