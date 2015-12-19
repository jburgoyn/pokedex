//
//  Pokemon.swift
//  pokedex
//
//  Created by Jonny B on 12/18/15.
//  Copyright © 2015 Jonny B. All rights reserved.
//

import Foundation


// This is the class that will hold all the detail for each pokemon
class Pokemon {
    
    // Create the variables for the class, these are private variables.
    private var _name: String!
    private var _pokedexId: Int!
    
    // Create the getters for the variables.
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    // Initialize the variables so can pass the data
    init(name: String, pokedexId: Int){
        self._name = name
        self._pokedexId = pokedexId
    }
}
