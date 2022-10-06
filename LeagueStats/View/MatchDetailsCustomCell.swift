//
//  MatchDetailsCustomCell.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 6.10.22..
//

import UIKit

class MatchDetailsCustomCell: UITableViewCell {

    @IBOutlet weak var killsLabel: UILabel!
    @IBOutlet weak var deathsLabel: UILabel!
    @IBOutlet weak var assitsLabel: UILabel!
    
    @IBOutlet weak var minionsKilled: UILabel!
    @IBOutlet weak var goldEarned: UILabel!
    
    @IBOutlet weak var championIcon: UIImageView!
    
    @IBOutlet weak var item0: UIImageView!
    @IBOutlet weak var item1: UIImageView!
    @IBOutlet weak var item2: UIImageView!
    @IBOutlet weak var item3: UIImageView!
    @IBOutlet weak var item4: UIImageView!
    @IBOutlet weak var item5: UIImageView!
    @IBOutlet weak var item6: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
