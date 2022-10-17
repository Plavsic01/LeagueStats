//
//  RankedDetailsViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 16.10.22..
//

import UIKit

class RankedDetailsViewController: UIViewController {
    
    
    
    @IBOutlet weak var rankedCollectionView: UICollectionView!
    
    
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
    var rankedDetails:[SummonerRanked] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rankedCollectionView.delegate = self
        rankedCollectionView.dataSource = self
        rankedCollectionView.register(UINib(nibName: K.rankedDetailsNibName, bundle: nil), forCellWithReuseIdentifier: K.rankedDetailsCellIdentifier)

        rankedData()
    }
    
  
    func rankedData(){
        if let sumSafe = summoner {
            summonerManager.fetchRankedData(summonerId: sumSafe.id) { rankedDetails in
                
                if rankedDetails.isEmpty {
                    self.rankedDetails.append(SummonerRanked(queueType: "RANKED_SOLO_5x5", tier:"Unranked", rank: "", leaguePoints: "0", wins:0, losses: 0))
                    self.rankedDetails.append(SummonerRanked(queueType: "RANKED_FLEX_SE", tier: "Unranked", rank: "", leaguePoints: "0", wins: 0, losses: 0))
                    
                }else if rankedDetails.count == 1 {
                    self.rankedDetails = rankedDetails
                    
                    if self.rankedDetails[0].queueType == "RANKED_SOLO_5x5"{
                        self.rankedDetails.append(SummonerRanked(queueType: "RANKED_FLEX_SE", tier: "Unranked", rank: "", leaguePoints: "0", wins: 0, losses: 0))
                    }else {
                        self.rankedDetails.append(SummonerRanked(queueType: "RANKED_SOLO_5x5", tier:"Unranked", rank: "", leaguePoints: "0", wins:0, losses: 0))
                    }
                }else {
                   
                    self.rankedDetails = rankedDetails
                    
                }
                
                DispatchQueue.main.async {
                    self.rankedCollectionView.reloadData()
                }
                    
                }
                
            }
        }
        
    }
    

extension RankedDetailsViewController: UICollectionViewDelegate {
    
}


extension RankedDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankedDetails.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.rankedDetailsCellIdentifier, for: indexPath) as! RankedDetailsCollectionViewCell
        
        
        cell.rankedIcon.image = UIImage(named: rankedDetails[indexPath.row].rankImgName)
        cell.rankedType.text = rankedDetails[indexPath.row].queueTypeFormatted
        cell.rankedTier.text = "\(rankedDetails[indexPath.row].tier) \(rankedDetails[indexPath.row].rank)"
        cell.rankedPoints.text = rankedDetails[indexPath.row].leaguePointsFormatted
        cell.rankedwinsLosses.text = "\(rankedDetails[indexPath.row].wins)W \(rankedDetails[indexPath.row].losses)L"
        cell.rankedWinRate.text = rankedDetails[indexPath.row].winRate
            
        
        return cell
    }
    
    
}



