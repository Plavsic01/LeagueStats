//
//  SummonerViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import UIKit
import Kingfisher

class SummonerViewController: UIViewController {
    
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerLevelLabel: UILabel!
    @IBOutlet weak var summonerIcon: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private var summonerManager = SummonerMenager()
    private var matchManager = MatchMananger()
    

    
    private var items:[UIImage] = []
    private var matchArray:[Match] = []

    var searchResult:String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:K.nibName, bundle:nil), forCellReuseIdentifier: K.cellIdentifier)
        summonerManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        summonerManager.fetchSummonerData(summonerName: searchResult!)
    
    }
    
    

    
    
    

}


extension SummonerViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MatchCustomCell
        
        
        /*
         Sort matchArray so that json results come from newest to oldest,
         because we need to have data sorted from newest game played to the oldest
         */
        
        let sortedArray =  matchArray.sorted(by:{$0.gameCreation > $1.gameCreation})
        
        // Download and display item images from every match played
            
        if sortedArray[indexPath.section].participant.win {
            cell.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            
        }else{
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
        
    
        
        cell.image1.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item0).png"))
        cell.image2.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item1).png"))
        cell.image3.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item2).png"))
        cell.image4.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item3).png"))
        cell.image5.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item4).png"))
        cell.image6.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item5).png"))
        cell.image7.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item6).png"))
        
        cell.championIcon.kf.setImage(with: URL(string:"\(K.summonerIconURL)\(sortedArray[indexPath.section].participant.championName).png"))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(3.0)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(3.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortedArray =  matchArray.sorted(by:{$0.gameCreation > $1.gameCreation})
        print(sortedArray[indexPath.section].participant.championName)
    }
    
}


extension SummonerViewController:SummonerMenagerDelegate {
    
    

    private func fetchSummonerIcon(summoner:Summoner){
        DispatchQueue.main.async {
            self.summonerIcon.kf.setImage(with: URL(string: "\(summoner.profileIconUrl)"))
            self.summonerIcon.layer.cornerRadius = self.summonerIcon.frame.size.width / 2
            self.summonerIcon.clipsToBounds = true
            self.summonerNameLabel.text = summoner.name
            self.summonerLevelLabel.text = "\(summoner.summonerLevel)"
            
        }
    }

    func didUpdateData(_ summonerMenager: SummonerMenager, summoner: Summoner) {

        // Fetch Match ids
        
        matchManager.fetchMatchArray(puuid:summoner.puuid) { matchIds in
            for id in matchIds {
        
                // Fetch Match data by match Id

                self.matchManager.fetchMatchData(matchId: id,summoner: summoner) { match in

                        DispatchQueue.main.async {
                            self.matchArray.append(match)
                            self.tableView.reloadData()

                        }
                    }
                    

                }
            }
            
            fetchSummonerIcon(summoner: summoner)
        }
        
        
        
        // Fetch Summoner icon
    
    func didGetError(_ summonerMenager: SummonerMenager, error: Error) {
        print(error) // this is for now
    }
    
    }

    









                                
