//
//  PokemonDetailVC.swift
//  PokeDic
//
//  Created by Mac on 2/26/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import UIKit
import Dispatch


class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var currentEvoImage: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evolutionLabel: UILabel!
    
    var pokemon: PokeVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameLabel.text = self.pokemon.name
        self.idLabel.text = "\(pokemon.pokeID)"
        pokemon.downloadPokemonDetail {
            //Whatever we write here will only be called after network call is completed
            DispatchQueue.main.async { [unowned self] in
                self.updateUI()
            }            
        }
    }
    
    func updateUI()  {       
        self.weightLabel.text = pokemon.weight
        self.heightLabel.text = pokemon.height
        self.attackLabel.text = pokemon.attack
        self.defenseLabel.text = pokemon.defense
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
 
    
}
