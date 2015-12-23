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
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    
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
