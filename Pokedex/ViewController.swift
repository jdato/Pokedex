//
//  ViewController.swift
//  Pokedex
//
//  Created by Johannes Dato on 17.12.20.
//

import UIKit

class ViewController: UITableViewController {

    var pokemon: [PokeApiPokemon] = []
    
    func capitalize(text: String) -> String {
        text.prefix(1).uppercased() + text.dropFirst()
    }
    
    // How many sections do we have?
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")
        guard let u = url else {
            return
        }
        
        URLSession.shared.dataTask(with: u) { (data, response, error) in
            guard let data = data else {
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokeApiResponse.self, from: data)
                self.pokemon = pokemonList.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("\(error)")
            }
        }.resume()
    }
    
    // How many rows has our section?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    // Fill the table wit each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = capitalize(text: pokemon[indexPath.row].name)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonSegue" {
            // If segue.destination can be cast to PokemonViewController go in
            if let destination = segue.destination as? PokemonViewController {
                destination.pokemon = pokemon[tableView.indexPathForSelectedRow!.row]
            }
        }
    }
}

