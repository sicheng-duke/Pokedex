//
//  PokeCell.swift
//  pokedex
//
//  Created by liusicheng on 15/10/20.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    var pokemon : Pokemon!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder:aDecoder)
        layer.cornerRadius = 5.0;
    }
    
    func configureCell(pokemon: Pokemon) {
        
        self.pokemon = pokemon
        
        nameLbl.text = self.pokemon.name.capitalizedString
    
        thumbImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    
}
