//
//  PokeCell.swift
//  PokeDex
//
//  Created by Kalyan Dechiraju on 04/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import SDWebImage

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonName: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5
    }
    
    func configureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        
        self.pokemonName.text = self.pokemon.name.capitalized
        //self.pokemonImage.image = UIImage(named: "\(self.pokemon.pokedexId)")
        //self.pokemonImage.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.pokemon.pokedexId).png"))
        self.pokemonImage.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.pokemon.pokedexId).png"), placeholderImage: UIImage(named: "Pokeball"))
    }
}
