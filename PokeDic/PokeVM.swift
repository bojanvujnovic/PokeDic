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
            pokemon.defense = newValue
        }
    }

    var description: String {
        get {
            return pokemon.description }
        set {
            pokemon.description = newValue
        }
    }
    
    var type: String {
        get {
            return pokemon.type }
        set {
            pokemon.type = newValue
        }
    }
    
    var nextEvolutionText: String {
        get {
            return  pokemon.nextEvolutionText}
        set {
            pokemon.nextEvolutionText = newValue
        }
    }
    var evolutionLevel: String {
        get {
            return pokemon.evolutionLevel }
        set {
            pokemon.evolutionLevel = newValue
        }
    }
    
    var evolutionName: String {
        get {
            return pokemon.evolutionName}
        set {
            pokemon.evolutionName = newValue
        }
    }
    
    var evolutionID: String {
        get {
            return pokemon.evolutionID }
        set {
            pokemon.evolutionID = newValue
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
            //Dictionary
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
                //Types
                if let types = dict[PokeDict.types] as? [Dictionary<String, String>], types.count > 0 {
                    let names = types.enumerated().map({   $0 < types.count - 1 ? $1[PokeDict.name]! + "/" : $1[PokeDict.name]!     }).joined()
                    self.type = names.capitalized
                } else {
                    self.type = ""
                }
                //Evolution
                if let evolutions = dict[PokeDict.evolutions] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                      let evolution = evolutions[0]
                      self.nextEvolutionText = "Next Evolution to: "
                      if let evolutionName = evolution[PokeDict.to] as? String {
                            //If not contains "mega"
                            if evolutionName.range(of: "mega") == nil {
                                self.evolutionName = evolutionName
                                if let uri = evolution[PokeDict.resource_uri] as? String {
                                    let newUri = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                    let changedUri = newUri.replacingOccurrences(of: "/", with: "")
                                    self.evolutionID = changedUri
                                    if let evolutionLevel = evolution[PokeDict.level] as? Int {
                                         self.evolutionLevel = "\(evolutionLevel)"
                                    } else {
                                        self.evolutionLevel = ""
                                    }
                                }
                            }
                      }
                    
                }
                
                //Description
                if let descriptions  = dict[PokeDict.descriptions] as? [Dictionary<String, AnyObject>], descriptions.count > 0  {
                    
                    if let resourceURI = descriptions[0][PokeDict.resource_uri] as? String {                        
                        let url = PokemonAPI.url_Base + resourceURI
                        
                         Alamofire.request(url, method: HTTPMethod.get).responseJSON(completionHandler: { (response) in
                            if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                                if let description = descriptionDict[PokeDict.description] as? String {
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")                                    
                                    self.description = newDescription
                                }
                            }
                            completed()
                         })
                    }
                }
               
            }
             completed()
        }
    }
    
}
