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
    override func viewDidLoad() {
        super.viewDidLoad()
        PokeName.text = pokemon.name
    }
}
