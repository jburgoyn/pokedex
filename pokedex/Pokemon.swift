//
//  Pokemon.swift
//  pokedex
//
//  Created by Jonny B on 12/18/15.
//  Copyright © 2015 Jonny B. All rights reserved.
//

import Foundation
import Alamofire


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
    private var _pokemonUrl: String!
    
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
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/"
    }
    
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        
        Alamofire.request(.GET, _pokemonUrl).responseJSON{ (response) -> Void in
            
            print(response.result) //SUCCESS
            
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String {
                    
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    
                    self._defense = "\(defense)"
                }
                
                print(self._defense)
                print(self._height)
                print(self._weight)
                print(self._attack)
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        
                        for var x = 1; x < types.count; x++ {
                            
                            if let name = types[x]["name"] {
                                
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    } else {
                        
                        self._type = ""
                    }
                    
                    print(self._type)
                }
                
            }
            
        }
        
        
        
        
    }
    
    
}
