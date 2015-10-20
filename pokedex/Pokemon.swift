//
//  Pokemon.swift
//  pokedex
//
//  Created by liusicheng on 15/10/20.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import Foundation

class Pokemon{
    
    private var _name: String!
    private var _pokedexId: Int!  //It should have value
    
    var name:String{
            return _name
        
    }
    
    var pokedexId: Int{
        
        return _pokedexId
    }
    
    init(name :String, pokedexId : Int){
        
        self._name = name
        self._pokedexId = pokedexId
    }
    
}