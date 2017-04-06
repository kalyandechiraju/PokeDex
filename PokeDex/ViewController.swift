//
//  ViewController.swift
//  PokeDex
//
//  Created by Kalyan Dechiraju on 01/04/17.
//  Copyright © 2017 Codelight Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonData = [Pokemon]()
    var filteredPokemonData = [Pokemon]()
    var inFilterMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = .done
        
        parseCsvData()
    }
    
    func parseCsvData() {
        let filePath = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        
        do {
            let csv = try CSV(contentsOfURL: filePath!)
            let rows = csv.rows
            for row in rows {
                let id = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let pokemon = Pokemon(name: name, pokedexId: id)
                pokemonData.append(pokemon)
                if pokemonData.count >= 30 {
                    break
                }
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            if inFilterMode {
                cell.configureCell(pokemon: filteredPokemonData[indexPath.row])
            } else {
                cell.configureCell(pokemon: pokemonData[indexPath.row])
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let poke = inFilterMode ? filteredPokemonData[indexPath.row] : pokemonData[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: poke)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? PokemonDetailViewController {
                if let poke = sender as? Pokemon {
                    destination.pokemon = poke
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inFilterMode {
            return filteredPokemonData.count
        }
        return pokemonData.count
        //return 30
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inFilterMode = false
            collectionView.reloadData()
            view.endEditing(true)
        } else {
            inFilterMode = true
            let searchString = searchBar.text!.lowercased()
            filteredPokemonData = pokemonData.filter({ ($0.name.range(of: searchString) != nil) })
            collectionView.reloadData()
        }
    }
    
}

