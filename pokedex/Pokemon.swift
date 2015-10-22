//
//  Pokemon.swift
//  pokedex
//
//  Created by liusicheng on 15/10/20.
//  Copyright © 2015年 liusicheng. All rights reserved.
//

import Foundation
import Alamofire
class Pokemon{
    
    private var _name: String!
    private var _pokedexId: Int!  //It should have value
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolution: String!
    private var _nextEvolutionId: String!
    private var _nextEvolutionLvl: String!
    private var _pokemonUrl: String!
    
    
    //getter methods
    var name:String{
            return _name
        
    }
    
    var pokedexId: Int{
        
        return _pokedexId
    }
    
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    var type: String{
        if _type == nil{
            _type = nil
        }
        return _type
    }
    
    var defense: String{
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var height: String{
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    var weight: String{
        if _weight == nil{
            _weight = ""
        }
        return _weight
    }
    
    var attack: String{
        if _attack == nil{
            _attack = ""
        }
        return _attack
    }
    
    var nextEvolution: String{
        
        if _nextEvolution == nil{
            _nextEvolution = ""
        }
        return _nextEvolution
        

    }
    
    var nextEvolutionId: String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLvl: String{
            if _nextEvolutionLvl == nil {
                _nextEvolutionLvl = ""
            }
            return _nextEvolutionLvl
        
        
    }
    
    var pokemonUrl: String{
        if _pokemonUrl == nil{
            _pokemonUrl = ""
        }
        return _pokemonUrl
    }
    
    init(name :String, pokedexId : Int){
        
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self.pokedexId)/" //create the Url
        
        
    }
    
    
    //download information through API
    func downloadPokemonDetails(completed: DownloadComplete){
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON{
            response in let result = response.result
            //convert JSON to dictionary
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                //get the weight
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                
                
//                print(self._weight)
//                print(self._height)
//                print(self._attack)
//                print(self._defense)
                
                //convert it and make it valid
                if let types = dict["types"] as? [Dictionary<String, String>]
                    where types.count > 0{
                    
                    //first element in Dictionary and its name
                    if let name = types[0]["name"]{
                        
                            self._type = name.capitalizedString
                    }
                    if types.count > 1 {
                        for var x = 1; x < types.count; x++ {
                            if let name = types[x]["name"]{
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                    
                }else{
                    self._type = ""
                }
//                print(self._type)
                
                //deal with description
                if let descarr = dict["descriptions"] as? [Dictionary<String, String>]
                    where descarr.count > 0{
                        
                    if let url = descarr[0]["resource_uri"]{
                    
                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON{
                        response in
                        let desResult = response.result
                        
                            if let descDict = desResult.value as? Dictionary<String, AnyObject>{
                                    
                                if let description  = descDict["description"] as? String{
                                        self._description = description
                                    
                                        //print(self._description)
                                }
                            }
                          //call completed after done
                          completed()
                        }
                    }
                        
                }else{
                    self._description = ""
                }
                
                
                //deal with evolutions
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>]
                    where evolutions.count > 0 {
                        
                        if let next = evolutions[0]["to"] as? String{
                            //deal with some wrong in api
                            if next.rangeOfString("mega") == nil{
                                
                                //grab number out of string
                                if let str = evolutions[0]["resource_uri"] as? String{
                                    //find the useless string and replace it
                                    let newStr = str.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                        
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvolutionId = num;
                                    self._nextEvolution = next
                                    
                                    
                                    
                                    if let lvl = evolutions[0]["level"] as? Int{
                                        self._nextEvolutionLvl = "\(lvl)"
                                    }
                                    
//                                    print(self._nextEvolution)
//                                    print(self._nextEvolutionId)
//                                    print(self._nextEvolutionLvl)
                                   
                                        
                                    
                                    
                                }
                            }
                            
                        }
                    
                }
                
            }
        }
        
    }
    
}