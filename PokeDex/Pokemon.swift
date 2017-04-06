//
//  Pokemon.swift
//  PokeDex
//
//  Created by Kalyan Dechiraju on 01/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pokemon {
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvoText: String!
    private var _pokemonURL: String!
    
    var name: String {
        return _name
    }
    var pokedexId: Int {
        return _pokedexId
    }
    
    var description: String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        self._pokemonURL = "\(BASE_URL)\(POKE_URL)\(self._pokedexId!)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL).responseJSON { (response) in
            let json = JSON(response.result.value!)
            if let weight = json["weight"].string {
                self._weight = weight
            }
            if let height = json["height"].string {
                self._height = height
            }
            if let defense = json["defense"].int {
                self._defense = "\(defense)"
            }
            if let attack = json["attack"].int {
                self._attack = "\(attack)"
            }
            
            if let types = json["types"].array, types.count > 0 {
                for x in 0..<types.count {
                    if let name = types[x]["name"].string {
                        if x == 0 {
                            self._type = name.capitalized
                        } else {
                            self._type? += "/\(name.capitalized)"
                        }
                    }
                }
            }
            
            if let descriptionArray = json["descriptions"].array, descriptionArray.count > 0 {
                if let url = descriptionArray[0]["resource_uri"].string {
                    Alamofire.request("\(BASE_URL)\(url)").responseJSON(completionHandler: { (dResponse) in
                        let descJson = JSON(dResponse.result.value!)
                        if let desc = descJson["description"].string {
                            self._description = desc.replacingOccurrences(of: "POKMON", with: "Pokemon").capitalized
                        }
                        completed()
                    })
                }
            }
            
            if let evolutions = json["evolutions"].array, evolutions.count > 0 {
                if let nextEvo = evolutions[0]["to"].string {
                    if nextEvo.range(of: "mega") == nil {
                        
                    }
                }
            }
            completed()
        }
    }
}
