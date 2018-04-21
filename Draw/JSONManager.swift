//
//  JSONManager.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/16/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import Foundation

class JSONManager {
    
    static func getJson(completion: @escaping ([Player])->()) {
        
        var playersArray = [Player]()
        let stringUrl = "http://internships-mobile.htec.co.rs/api/players"
        
        //try to create URL from a given string
        if let url = URL(string: stringUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            //create url session
            let urlSession = URLSession.shared.dataTask(with: request) { (data, response, error) in
                //Check for errors
                guard error == nil else {
                    print("Error happened! \(error!)")
                    return
                }
                
                // NO Errors! Continue with data extraction
                if let data = data {
                    do{
                        //Serialize Json
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                        let data = json["data"] as! [[String: Any]]
        
                        //Extract info for each player
                        var trainer: Trainer?
                        for p in data {
                            let id = p["id"] as? Int ?? 0
                            let firstName = p["firstName"] as? String ?? ""
                            let lastName = p["lastName"] as? String ?? ""
                            let points = p["points"] as? Int ?? 0
                            let isProfessional = p["isProfessional"] as? Int ?? 0
                            let dob = p["created_at"] as? String ?? ""
                            
                            let trainers = p["trainers"] as? [[String:Any]]
                            for t in trainers! {
                                let trainerFirstName = t["firstName"] as? String ?? ""
                                let trainerLastName = t["lastName"] as? String ?? ""
                                let trainerId = t["id"] as? Int ?? 0
                                let sport = t["sport"] as? String ?? ""
                                
                            trainer = Trainer(id: trainerId, firstName: trainerFirstName, lastName: trainerLastName, sport: sport)
                            }
                            //create players
                            let player = Player(id: id, firstName: firstName, lastName: lastName, DOB: dob, isProfessional: isProfessional, points: points, photo: "player", description: "This is the description of the selected player, which can be fully viewed after clicking on the players row in this table view representation.", trainer: trainer)
                            //add created player to a playersArray
                            playersArray.append(player)
                            trainer = nil
                         }
                        
                    } catch {
                        //catch any error during serialization
                        print("Unable to serialize json")
                    }
                    //sort player by number of points Descending
                    playersArray.sort(by: { (p1, p2) -> Bool in
                        p1.points > p2.points
                    })
                    //call completion once all players are created
                    completion(playersArray)
                }
            }
            urlSession.resume()
        }
    }
    
    static func getPlayer(withID id: Int, completion: @escaping (Player)->()) {
        //default empty player
        var player = Player(id: 0, firstName: "", lastName: "", DOB: "", isProfessional: 0, points: 0, photo: "", description: "", trainer: nil)
        
        //get url for each player according to it's ID
        let stringUrl = "http://internships-mobile.htec.co.rs/api/players/\(id)"
        
        //check url
    
        if let url = URL(string: stringUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("message", forHTTPHeaderField: "x-tournament-id")
            //create url session
            let urlSession = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                //check for errors
                guard error == nil else {
                    print("Error happened)")
                    return
                }
                
                //get data from API
                if let data = data {
                    do {
                        //extract data for a selected (by ID) player
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                        print(json)
                        
                        let data = json["data"] as! [String: Any]
                        
                        let playerId = data["id"] as? Int ?? 0
                        let firstName = data["firstName"] as? String ?? ""
                        let lastName = data["lastName"] as? String ?? ""
                        let dob = data["dateOfBirth"] as? String
                        let descr = data["description"] as? String ?? ""
                        let points = data["points"] as? Int ?? 0
                        let profileImage = data["profileImageUrl"] as? String ?? ""
                        let isPro = data["isProfessional"] as? Int ?? 0
                        let trainers = data["trainers"] as! [[String: Any]]
                        
                        
                        var trainer: Trainer? //trainer is optional
                        
                        //if there is a trainer, get his data
                        for t in trainers {
                            let trainerFirstName = t["firstName"] as? String ?? ""
                            let trainerLastName = t["lastName"] as? String ?? ""
                            let trainerId = t["id"] as? Int ?? 0
                            let sport = t["sport"] as? String ?? ""
                            trainer = Trainer(id: trainerId, firstName: trainerFirstName, lastName: trainerLastName, sport: sport)
                        }
                        //Format date for more human readable format
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                        let date = dateFormatter.date(from: dob!)
                        dateFormatter.dateFormat = "E, MMM d, yyyy"
                        let formatedDob = dateFormatter.string(from: date!)
                        
                        //create a player
                        player = Player(id: playerId, firstName: firstName, lastName: lastName, DOB: "\(formatedDob)", isProfessional: isPro, points: points, photo: profileImage, description: descr, trainer: trainer)
                    } catch {
                        
                        print("Error! Not  valid json")
                    }
                    completion(player)
                }
            }
            urlSession.resume()
        }
        
    }
}
