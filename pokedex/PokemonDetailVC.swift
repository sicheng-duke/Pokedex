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
    
    
    
    @IBAction func backButtonPress(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeName.text = pokemon.name.capitalizedString
        mainImage.image = UIImage(named:"\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            //be called after download is done
            
        }
        
    }
}
