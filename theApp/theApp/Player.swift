//
//  Player.swift
//  theApp
//
//  Created by user220765 on 11/14/22.
//

import UIKit

class Player: Codable {
    var nombre: String = ""
    var tiempo : Double
    
    
    init(nombre: String, tiempo: Double) {
        self.nombre = nombre
        self.tiempo = tiempo
    }


}
