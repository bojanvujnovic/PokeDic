//
//  PokeCell.swift
//  PokeDic
//
//  Created by Mac on 2/24/17.
//  Copyright © 2017 Boki. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
   
    fileprivate var pokeVM: PokeVM!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 7.0
    }
    
    func configureCell(pokemon: PokeVM)  {
        self.pokeVM = pokemon
        self.imageView.image = self.pokeVM.image
        self.name.text = self.pokeVM.name        
    }
     
    
}
