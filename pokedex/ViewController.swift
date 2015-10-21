//
//  ViewController.swift
//  pokedex
//
//  Created by liusicheng on 15/10/20.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UISearchBarDelegate{
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var SearchPoke: UISearchBar!
    
    var filteredPokemon = [Pokemon]() // using for the search bar
    var pokemon = [Pokemon]()
    var inSearchMode = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        SearchPoke.delegate = self
        SearchPoke.returnKeyType = UIReturnKeyType.Done  //hide the keyboard
        parsePokemonCSV()
    }
    func parsePokemonCSV(){
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")
        
        do{
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            for row in rows{
                let pokeId = Int(row["id"]!)!
                let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
            }
            //print(rows)
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell  = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            //let pokemon = Pokemon(name: "Test", pokedexId: indexPath.row+1)//singal item has own row
            let poke : Pokemon!//grab currenr poke
            
            if inSearchMode{
                poke = filteredPokemon[indexPath.row] // check if in the Search Mode
            }else
            {
                poke = pokemon[indexPath.row]
            }
            cell.configureCell(poke)
            
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        //deque just like table view, reuse this cell
    }//control the cell index path return the cell
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        //grab the select to new view
        let poke : Pokemon!
        if inSearchMode{
            
            poke = filteredPokemon[indexPath.row]  //pass the search pokemon value
            
            
        }else{
            
            poke = pokemon[indexPath.row]   //pass the select pokemon value
        }
        
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)  //use Segue to send pokemon
        
    }
    //item select
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filteredPokemon.count
        }
        
        return pokemon.count
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105,105)
    }//set the size
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if SearchPoke.text == nil || SearchPoke.text == "" {
            inSearchMode = false
            view.endEditing(true) //close the key board
            collection.reloadData()
        }
        else{
            
            inSearchMode = true
            let lower = SearchPoke.text!.lowercaseString
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            //go through array  $0 grab element in array
            // rangeOfString go through all the word , if it contains this array
            //find the element
            collection.reloadData()
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC"{
            
            if let detailsVC = segue.destinationViewController as? PokemonDetailVC{
                
                if let poke = sender as? Pokemon{
                    
                    detailsVC.pokemon = poke
                }
            }
        }
    }
    

}

