//
//  PokemonViewController.swift
//  Pokedex
//
//  Created by Johannes Dato on 17.12.20.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var type1Label: UILabel!
    @IBOutlet var type2Label: UILabel!
    var pokemon: PokeApiPokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: pokemon.url)
        guard let u = url else {
            return
        }
        
        type1Label.text = ""
        type2Label.text = ""
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonData = try JSONDecoder().decode(PokemonApiData.self, from: data)
                
                DispatchQueue.main.async {
                    self.nameLabel.text = self.pokemon.name
                    self.numberLabel.text = String(format: "#%03d", pokemonData.id)
                    
                    for typeEntry in pokemonData.types {
                        if typeEntry.slot == 1 {
                            self.type1Label.text = typeEntry.type.name
                        } else if typeEntry.slot == 2 {
                            self.type2Label.text = typeEntry.type.name
                        }
                    }
                }
            } catch let error {
                print("\(error)")
            }
        }.resume()
        
        
    }
}
