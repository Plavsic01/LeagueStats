//
//  MatchCustomCell.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 24.9.22..
//

import UIKit

class MatchCustomCell: UITableViewCell {

    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var championIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        print("AWAKE")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

