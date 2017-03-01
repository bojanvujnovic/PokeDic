//
//  ViewController.swift
//  PokeDic
//
//  Created by Mac on 2/24/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import UIKit
import AVFoundation

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var pokeCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var pokemons = [PokeVM]()
    var filteredPokemon = [PokeVM]()
    var inSearchMode = false
    
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pokeCollectionView.dataSource = self
        self.pokeCollectionView.delegate = self
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
        self.parsePokemonCSV()
        //self.initAudio()        
    }
    
    func initAudio() {
        
        if let path = Bundle.main.path(forResource: "music", ofType: "mp3"), let musicURL = URL(string: path)  {
            do {
                musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                musicPlayer.prepareToPlay()
                musicPlayer.numberOfLoops = -1
                musicPlayer.play()
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    //Do not scroll Table View down when in top upmost position.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y > 0)
    }
    
    func parsePokemonCSV() {
        if let path  = Bundle.main.path(forResource: "pokemon", ofType: "csv") {
            do {
                let csv = try CSV(contentsOfURL: path)
                let rows = csv.rows
                pokemons = rows.map({ (dict: [String : String]) -> PokeVM in
                    var pokemon: Pokemon!
                    var pokeVM: PokeVM!
                    if let name = dict["identifier"] , let id = dict["id"], let idInt = Int(id) {
                        
                        pokemon = Pokemon(name: name, pokeID: idInt)                        
                        pokeVM = PokeVM(pokemon: pokemon)
                        
                    }
                    return pokeVM
                })
                
            } catch let error {
                print(error.localizedDescription)
            }
        }          
    }
    
    //CollectionView delegate and data source methods
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return    !self.inSearchMode ?  pokemons.count : self.filteredPokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let pokemon =  !self.inSearchMode ? pokemons[indexPath.row] : self.filteredPokemon[indexPath.row]
            
            cell.configureCell(pokemon: pokemon)
            return cell
        } else {
            return UICollectionViewCell() }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = self.inSearchMode ? self.filteredPokemon[indexPath.row] : self.pokemons[indexPath.row]
        performSegue(withIdentifier: "PokemonDetailVC", sender: pokemon)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 105, height: 105)
    }
    
    
    @IBAction func musicButtonPressed(_ sender: UIButton) {
        if musicPlayer.isPlaying {
            musicPlayer.pause()
            sender.alpha = 0.2
        } else {
            musicPlayer.play()
            sender.alpha = 1.0 
        }
    }
    //The Keyboard is being dismissed  when Search button is clicked.
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    //Search Bar delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if self.searchBar.text == nil || self.searchBar.text == "" {
           self.inSearchMode = false
            self.pokeCollectionView.reloadData()
            //The Keyboard is being dissmised when the search is deleted
            view.endEditing(true)
        } else  {
            self.inSearchMode = true
            let lower = self.searchBar.text!.lowercased()
            //Only Pokemons with names containing a characters in search bar will be shown.
            self.filteredPokemon = pokemons.filter({  $0.name.range(of: lower)  != nil    })
            self.pokeCollectionView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC" {
            if let destination = segue.destination as? PokemonDetailVC, let pokemon = sender as? PokeVM {
                destination.pokemon = pokemon
            }
        }
    }
    

}














