//
//  DrawViewController.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/18/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    var players: [Player] = []
    var leftSide: [Player] = []
    var rightSide: [Player] = []
    var activityIndicator = Activity()
    var mergedArray: [Player] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicator.activityIndicator)
        DispatchQueue.main.async {
            self.activityIndicator.startActivity()
        }
        activityIndicator.activityIndicator.frame.origin = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
        players.sort(by: sortDesc(p1:p2:))
        
        for i in 0..<players.count {
            if i % 2 == 0 {
                rightSide.append(players[i])
            } else {
                leftSide.append(players[i])
            }
        }
        let reversedRight: [Player] = rightSide.reversed()
        let mergedZipArray = zip(leftSide, reversedRight)
        
        for p in mergedZipArray {
            print(p.0.points, p.1.points)
            mergedArray.append(p.0)
            mergedArray.append(p.1)
        }
    
        for i in 0..<mergedArray.count  {
            if i % 2 == 0 {
                displayPairs(playerOne: mergedArray[i] ,playerTwo: mergedArray[i + 1], andPosition: i)
            }
            
        }
    }
    //Sorting helper functions
    func sortDesc(p1: Player, p2: Player) -> Bool {
        return p1.points > p2.points
    }
    
    func sortAsc(p1: Player, p2: Player) -> Bool {
        return p1.points < p2.points
    }
    
    //Drawing players algorithm implementation
    let height = 100
    let margin = 30
    func displayPairs(playerOne p1: Player, playerTwo p2: Player, andPosition position: Int) {
        let playerView = DrawnPlayerView(frame: CGRect(x: 10, y: position / 2 * (margin + height) + margin, width: 350, height: height))
        playerView.layer.borderColor = UIColor.blue.cgColor
        playerView.layer.borderWidth = 1
        JSONManager.getPlayer(withID: p1.id) { (player) in
            DispatchQueue.main.async {
                playerView.playerOneFirstName.text = player.firstName
                playerView.playerOneLastName.text = player.lastName
                playerView.playerOnePoints.text = "\(player.points)"
                if let url = URL(string: player.photo) {
                    let imageData = try! Data(contentsOf: url)
                    playerView.playerOnePhoto.image = UIImage(data: imageData)
                } else {
                    //else, display default photo
                    playerView.playerOnePhoto.image = UIImage(named: "player")
                }
                
                self.scrollView.addSubview(playerView)
            }
        }
        JSONManager.getPlayer(withID: p2.id) { (player) in
            DispatchQueue.main.async {
                playerView.playerTwoFirstName.text = player.firstName
                playerView.playerTwoLastName.text = player.lastName
                playerView.playerTwoPoints.text = "\(player.points)"
                if let url = URL(string: player.photo) {
                    let imageData = try! Data(contentsOf: url)
                    playerView.playerTwoPhoto.image = UIImage(data: imageData)
                } else {
                    //else, display default photo
                    playerView.playerTwoPhoto.image = UIImage(named: "player")
                }
                
                self.scrollView.addSubview(playerView)
                self.activityIndicator.stopActivity()
                self.activityIndicator.activityIndicator.removeFromSuperview()
            }
        }
        scrollView.contentSize.height = (playerView.frame.size.height + CGFloat(margin)) * CGFloat(mergedArray.count / 2) + CGFloat(margin)
    }
}
