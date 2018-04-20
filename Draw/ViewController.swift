//
//  ViewController.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/16/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    //declare and initialize an array of Player objects
    var players = [Player]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get the players data from API
        JSONManager.getJson(completion: { (players) in
            DispatchQueue.main.async {
                //assign completion result to players array
                self.players = players
                
                //refreshes tableView once all the info is downloaded
                self.tableView.reloadData()
            }
        })
    }
    @IBAction func drawButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showDraw", sender: self)
    }
}

//implementing UITableViewDataSource and UITableViewDelegate in an extension for better code organisation

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerCell
        cell.firstName.text = players[indexPath.row].firstName
        cell.lastName.text = players[indexPath.row].lastName
        cell.trainer.text = players[indexPath.row].trainer != nil ? players[indexPath.row].trainer!.firstName + " " + players[indexPath.row].trainer!.lastName : "None"
        cell.isProImage.image = players[indexPath.row].isProfessional == 1 ? UIImage(named: "pro") : UIImage()
        cell.points.text = "\(players[indexPath.row].points)"
        
        return cell
    }
    
    //When row is selected, segue to DetailedViewController is performed
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPlayer", sender: self)
    }
    
    //Preparing data for segue transition to another viewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayer" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationVC = segue.destination as? DetailViewController
                if let viewController = destinationVC {
                    //Passing only the ID of the selected player to DetailViewController
                    //All the other info is extracted from another API call
                    viewController.playerId = players[indexPath.row].id
                }
            }
        } else if segue.identifier == "showDraw" {
            let destinationVC = segue.destination as? DrawViewController
            if let viewController = destinationVC {
                //Passing all the players to DrawViewController
                viewController.players = players
                
            }
        }
    }
    
}
