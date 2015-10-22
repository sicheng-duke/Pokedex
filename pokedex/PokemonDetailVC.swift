//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by liusicheng on 15/10/21.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon:Pokemon!
    
    @IBOutlet weak var PokeName: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var evilLbl: UILabel!
    @IBOutlet weak var Current: UIImageView!
    @IBOutlet weak var next: UIImageView!
    
    

    @IBAction func backButtonPress(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeName.text = pokemon.name.capitalizedString
        let img = UIImage(named:"\(pokemon.pokedexId)")
        mainImage.image = img
        Current.image = img

        
        pokemon.downloadPokemonDetails { () -> () in
            //be called after download is done
            print("Did we get here")
            self.updateUI()
        }
        
    }
    
    func updateUI(){
        
            Description.text = pokemon.description
            typeLbl.text = pokemon.type
            defenseLbl.text = pokemon.defense
            heightLbl.text = pokemon.height
            idLbl.text = "\(pokemon.pokedexId)"
            weightLbl.text = pokemon.weight
            attackLbl.text = pokemon.attack
        
            if pokemon.nextEvolutionId == "" {
                evilLbl.text = "No Evolutions"
                next.hidden = true
                
            }else{
                next.hidden = false
                next.image = UIImage(named: pokemon.nextEvolutionId)
                var str = "Next Evolution: \(pokemon.nextEvolution)"
                if pokemon.nextEvolutionLvl != "" {
                    str += " - LVL \(pokemon.nextEvolutionLvl)"
                    evilLbl.text = str
                }else{
                    evilLbl.text = str
                }
                
            }
        
        
        
    }
}
