//
//  DrawnPlayerView.swift
//  Draw
//
//  Created by Dusan Juranovic on 4/19/18.
//  Copyright © 2018 Dusan Juranovic. All rights reserved.
//

import UIKit

class DrawnPlayerView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var playerOneFirstName: UILabel!
    @IBOutlet weak var playerOneLastName: UILabel!
    @IBOutlet weak var playerOnePoints: UILabel!
    @IBOutlet weak var playerOnePhoto: UIImageView!
    
    @IBOutlet weak var playerTwoFirstName: UILabel!
    @IBOutlet weak var playerTwoLastName: UILabel!
    @IBOutlet weak var playerTwoPoints: UILabel!
    @IBOutlet weak var playerTwoPhoto: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("DrawnPlayerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
