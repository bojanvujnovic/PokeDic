//
//  Pokemon.swift
//  PokeDic
//
//  Created by Mac on 2/24/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import Foundation

class Pokemon {
    
     private var _name: String!
     private var _pokeID: Int!
     private var _description: String!
     private var _type: String!
     private var _defense: String!
     private var _height: String!
     private var _weight: String!
     private var _attack: String!
     private var _nextEvolutionTxt: String!
     private var _evolutionLevel: String!
     private var _evolutionName: String!
     private var _evolutionID: String!
     private var _pokemonURL: String!
    
    //Data Protection
    var name: String {
            return _name
    }

    var pokeID: Int {
            return _pokeID        
    }
    
    var description: String {
        get {
            if _description == nil {   _description = ""     }
            return _description
        } set {
            _description = newValue
        }
    }
    
    var type: String {
        get {
            if _type == nil {   _type = ""     }
            return _type
        } set {
            _type = newValue
        }
    }
    
    var defense: String {
        get {
            if _defense == nil {   _defense = ""     }
            return _defense
        } set {
            _defense = newValue
        }
    }
    
    var height: String {
        get {
            if _height == nil {   _height = ""     }
            return _height
        } set {
            _height = newValue
        }
    }
    
    var weight: String {
        get {
            if _weight == nil {   _weight = ""     }
            return _weight
        } set {
            _weight = newValue
        }
    }
    
    var attack: String {
        get {
            if _attack == nil {   _attack = ""     }
                 return _attack
        } set {
            _attack = newValue
        }
    }
    
    var evolutionLevel: String {
        get {
            if _evolutionLevel == nil {  _evolutionLevel = ""   }
            return _evolutionLevel }
        set {
            _evolutionLevel = newValue
        }
    }
    
    var evolutionName: String {
        get {
            if _evolutionName == nil {  _evolutionName = ""   }
            return _evolutionName }
        set {
            _evolutionName = newValue
        }
    }
    var evolutionID: String {
        get {
            if _evolutionID == nil {  _evolutionID = ""   }
            return _evolutionID }
        set {
            _evolutionID = newValue
        }
    }
    
    var nextEvolutionText: String {
        get {
        if _nextEvolutionTxt == nil {  _nextEvolutionTxt = ""   }
            return _nextEvolutionTxt }
        set {
            _nextEvolutionTxt = newValue
        }
    }
    
    var pokemonURL: String {
        get {
            return _pokemonURL
        } set {
            _pokemonURL = newValue
        }
    }

    
    init(name: String, pokeID: Int ) {
        self._name = name
        self._pokeID = pokeID
        self._pokemonURL = "\(PokemonAPI.pokemonURL)\(pokeID)"
    }
    
    
    
}
