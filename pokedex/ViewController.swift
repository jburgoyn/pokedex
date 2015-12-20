//
//  ViewController.swift
//  pokedex
//
//  Created by Jonny B on 12/18/15.
//  Copyright © 2015 Jonny B. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    
    @IBOutlet weak var collection: UICollectionView!
    
    @IBOutlet weak var musicBtn: UIButton!
    
    @IBOutlet weak var searcBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    
    var musicPlayer: AVAudioPlayer!
    var inSearchMode = false
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        searcBar.delegate = self
        searcBar.returnKeyType = UIReturnKeyType.Done
        
        parsePokemonCSV()
        initAudio()
    }
    
    func initAudio() {
        
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {
            
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string:path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        } catch let err as NSError {
            
            print(err.debugDescription)
        }
        
    }
    
    func parsePokemonCSV() {
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        do {
            
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
                
            }
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            let poke: Pokemon!
            
            if inSearchMode{
                 poke = filteredPokemon[indexPath.row]
                
            } else {
                poke = pokemon[indexPath.row]
            }
            
           
            cell.configureCell(poke)
            return cell
            
        } else {
            
            return UICollectionViewCell()
        }
    }
    
    // this is the code that executes whenever an item is tapped in the collection view.
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let poke: Pokemon!
        
        if inSearchMode {
            
            poke = filteredPokemon[indexPath.row]
        } else {
            
            poke = pokemon[indexPath.row]
        }
        
        // perform the segue with the segue id we declared, and we are sending the poke variable.
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if inSearchMode {
        return filteredPokemon.count
            
        } else {
            
            return pokemon.count
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(85, 85)
    }
    
    @IBAction func musicBtnPressed(sender: UIButton) {
        
        if musicPlayer.playing {
            
            musicPlayer.stop()
            musicBtn.alpha = 0.3
            
        } else {
            
            musicPlayer.play()
            musicBtn.alpha = 1.0
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searcBar.text == nil || searcBar.text == "" {
            
            inSearchMode = false
            view.endEditing(true) // makes the keyboard go away
            collection.reloadData()
            
        } else {
            
            inSearchMode = true
            let lower = searcBar.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // this is the function to prepare for a segue. 
        if segue.identifier == "PokemonDetailVC" {
            
            // get the destination view controller ready
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC {
                
                // tell the destination VC what the sender is going to be typed as
                if let poke = sender as? Pokemon {
                    
                    // Declaring what the actual variable in the destination VC is equal to from the origin VC.
                    detailsVC.pokemon = poke
                }
            }
        }
    }
}




















