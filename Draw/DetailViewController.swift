//
//  DetailViewController.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/16/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var playerId: Int?
    var player: Player?
    var activityIndicatorView = Activity()
    
    @IBOutlet weak var proImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var playerPhoto: UIImageView! {
        didSet {
            playerPhoto.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dob: UILabel!
    @IBOutlet weak var points: UILabel!
    @IBOutlet weak var playerDescription: UITextView!
    
    @IBOutlet weak var trainer: UILabel!
    @IBOutlet weak var id: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //configure activityIndicatorView
        activityIndicatorView.activityIndicator.frame.origin = CGPoint(x: playerPhoto.frame.size.width / 2, y: playerPhoto.frame.size.height / 2)
        activityIndicatorView.activityIndicator.color = UIColor.red
        
        //add activityIndicator to playerPhoto view
        playerPhoto.addSubview(activityIndicatorView.activityIndicator)
        
        //start Activity on mainQueue
        DispatchQueue.main.async {
            self.activityIndicatorView.startActivity()
        }
        
        JSONManager.getPlayer(withID: playerId!, completion: {p in
            DispatchQueue.main.async {
                //check if profile photo url is valid
                //if so, download and display the photo
                if let url = URL(string: p.photo) {
                    let imageData = try! Data(contentsOf: url)
                    self.playerPhoto.image = UIImage(data: imageData)
                } else {
                    //else, display default photo
                    self.playerPhoto.image = UIImage(named: "player")
                }
                self.name.text = p.firstName + " " + p.lastName
                self.dob.text = "DOB: \(p.DOB)"
                self.points.text = "\(p.points)"
                self.playerDescription.text = p.description
                self.id.text = "\(p.id)"
                if let train = p.trainer {
                    self.trainer.text = train.firstName + " " + train.lastName
                } else {
                    self.trainer.text = "None"
                }
                self.proImage.image = p.isProfessional == 1 ? UIImage(named: "pro") : UIImage()
                
                //stop activityIndicator once data is donloaded and remove from parent view
                self.activityIndicatorView.stopActivity()
                self.activityIndicatorView.activityIndicator.removeFromSuperview()
            }
            
        })
    }
    
}
