//
//  Trainer.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/16/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import Foundation

class Trainer {
    let firstName: String
    let lastName: String
    let id: Int
    let sport: String
    
    init(id: Int, firstName: String, lastName: String, sport: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.sport = sport
    }
}
