//
//  Activity.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/19/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import Foundation
import UIKit

class Activity: UIActivity {
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    func startActivity() {
        print("Started")
        DispatchQueue.main.async {
            self.activityIndicator.frame.size = CGSize(width: 40, height: 40)
            self.activityIndicator.color = .red
            self.activityIndicator.startAnimating()
        }
    }
    
    func stopActivity() {
        print("Stopped")
        activityIndicator.stopAnimating()
    }
}
