//
//  ViewController.swift
//  Pokedex
//
//  Created by Johannes Dato on 17.12.20.
//

import UIKit

class ViewController: UITableViewController {

    let pokemon = [
        Pokemon(name: "Glumanda", number: 1),
        Pokemon(name: "Bisasam", number: 2),
        Pokemon(name: "Schiggy", number: 3)
    ]
    
    // How many sections do we have?
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // How many rows has our section?
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    // Fill the table wit each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        cell.textLabel?.text = pokemon[indexPath.row].name
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

