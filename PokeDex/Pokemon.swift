//
//  Pokemon.swift
//  PokeDex
//
//  Created by Kalyan Dechiraju on 01/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
    }
}
