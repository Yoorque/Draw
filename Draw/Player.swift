//
//  Player.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/16/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import Foundation

struct Player {
    let id: Int
    let firstName: String
    let lastName: String
    let DOB: String
    let isProfessional: Int
    let points: Int
    let photo: String
    let description: String
    let trainer: Trainer?
    
    init(id: Int, firstName: String, lastName: String, DOB: String, isProfessional: Int, points: Int, photo: String, description: String, trainer: Trainer?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.DOB = DOB
        self.isProfessional = isProfessional
        self.points = points
        self.photo = photo
        self.description = description
        self.trainer = trainer
    }
}
