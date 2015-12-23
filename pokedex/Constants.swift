//
//  Constants.swift
//  pokedex
//
//  Created by Jonny B on 12/22/15.
//  Copyright © 2015 Jonny B. All rights reserved.
//

import Foundation

let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"

// this is creating a simple clusure. A block of code that is called whenever we want it to.
typealias DownloadComplete = () -> ()