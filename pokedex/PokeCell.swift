//
//  PokeCell.swift
//  pokedex
//
//  Created by Jonny B on 12/18/15.
//  Copyright © 2015 Jonny B. All rights reserved.
//

import UIKit

// This file contains the information for each collection cell template.
class PokeCell: UICollectionViewCell {
    
    // These are the variable for each item inside each cell.
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    // Store a class Pokemon item.
    var pokemon: Pokemon!
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
}
