//
//  RankedDetailsViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 16.10.22..
//

import UIKit

class RankedDetailsViewController: UIViewController {
    
    @IBOutlet weak var soloQIcon: UIImageView!
    @IBOutlet weak var flexIcon: UIImageView!
    @IBOutlet weak var soloRankLabel: UILabel!
    @IBOutlet weak var flexRankLabel: UILabel!
    @IBOutlet weak var soloLpLabel: UILabel!
    @IBOutlet weak var flexLpLabel: UILabel!
    @IBOutlet weak var soloWinsLossesLabel: UILabel!
    @IBOutlet weak var flexWinsLossesLabel: UILabel!
    @IBOutlet weak var soloWinRate: UILabel!
    @IBOutlet weak var flexWinRate: UILabel!
    
    var summonerManager = SummonerMenager()
    var summoner:Summoner?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showRankedData()
    }
 
    func showRankedData(){
        if let sumSafe = summoner {
            summonerManager.fetchRankedData(summonerId: sumSafe.id) { rankedDetails in
                
                if !rankedDetails.isEmpty && rankedDetails.count == 1 {
                    
                    if rankedDetails[0].queueType == "RANKED_SOLO_5x5" {
                        DispatchQueue.main.async {
                            self.soloQIcon.image = UIImage(named: rankedDetails[0].soloQRank)
                            self.soloRankLabel.text = rankedDetails[0].tier + " " + rankedDetails[0].rank
                            self.soloLpLabel.text = "\(rankedDetails[0].leaguePoints) LP"
                            self.soloWinsLossesLabel.text = rankedDetails[0].winsAndLosses
                            self.soloWinRate.text = rankedDetails[0].winRate
                        }
                        
                    }else if rankedDetails[0].queueType == "RANKED_FLEX_SR" {
                        DispatchQueue.main.async {
                            self.flexIcon.image = UIImage(named: rankedDetails[0].flexRank)
                            self.flexRankLabel.text = rankedDetails[0].tier + " " + rankedDetails[0].rank
                            self.flexLpLabel.text = "\(rankedDetails[0].leaguePoints) LP"
                            self.flexWinsLossesLabel.text = rankedDetails[0].winsAndLosses
                            self.flexWinRate.text = rankedDetails[0].winRate
                        }

                    }
                } else if rankedDetails.count == 2 {
                    DispatchQueue.main.async {
                        self.soloQIcon.image = UIImage(named: rankedDetails[0].soloQRank)
                        self.soloRankLabel.text = rankedDetails[0].tier + " " + rankedDetails[0].rank
                        self.soloLpLabel.text = "\(rankedDetails[0].leaguePoints) LP"
                        self.soloWinsLossesLabel.text = rankedDetails[0].winsAndLosses
                        self.soloWinRate.text = rankedDetails[0].winRate
                        
                        self.flexIcon.image = UIImage(named: rankedDetails[1].flexRank)
                        self.flexRankLabel.text = rankedDetails[1].tier + " " + rankedDetails[1].rank
                        self.flexLpLabel.text = "\(rankedDetails[1].leaguePoints) LP"
                        self.flexWinsLossesLabel.text = rankedDetails[1].winsAndLosses
                        self.flexWinRate.text = rankedDetails[1].winRate
                    }
                    
                }
                
            }
        }
        
    }
    
    
}


