//
//  RankedDetailsCollectionViewCell.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 17.10.22..
//

import UIKit

class RankedDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var rankedIcon: UIImageView!
    @IBOutlet weak var rankedType: UILabel!
    @IBOutlet weak var rankedTier: UILabel!
    @IBOutlet weak var rankedPoints: UILabel!
    @IBOutlet weak var rankedwinsLosses: UILabel!
    @IBOutlet weak var rankedWinRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

}
