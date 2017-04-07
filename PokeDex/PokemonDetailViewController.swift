//
//  PokemonDetailViewController.swift
//  PokeDex
//
//  Created by Kalyan Dechiraju on 04/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit
import SDWebImage

class PokemonDetailViewController: UIViewController {

    var pokemon: Pokemon!
    @IBOutlet weak var pokemonTitle: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evoLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTitle.text = pokemon.name.capitalized
        mainImage.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.pokemon.pokedexId).png"), placeholderImage: UIImage(named: "Pokeball"))
        currentEvoImage.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.pokemon.pokedexId).png"), placeholderImage: UIImage(named: "Pokeball"))
        pokemon.downloadPokemonDetail {
            self.updateUI()
        }
    }
    
    func updateUI() {
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        descriptionLabel.text = pokemon.description
        typeLabel.text = pokemon.type
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        
        if pokemon.nextEvoId == "" {
            evoLabel.text = "No Evolutions"
            nextEvoImage.isHidden = true
        } else {
            nextEvoImage.isHidden = false
            nextEvoImage.sd_setImage(with: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(self.pokemon.nextEvoId).png"), placeholderImage: UIImage(named: "Pokeball"))
            evoLabel.text = "Next Evolution: \(pokemon.nextEvoName) - LVL \(pokemon.nextEvoLevel)"
        }
        
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
