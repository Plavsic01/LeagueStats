//
//  SummonerViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import UIKit

class SummonerViewController: UIViewController {
    
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerIcon: UIImageView!
        
    var searchResult:String?
    
    var summonerManager = SummonerMenager()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        summonerManager.delegate = self
        summonerManager.fetchSummonerData(summonerName: searchResult!)

    }
    

}


extension SummonerViewController:SummonerMenagerDelegate {


    func didUpdateData(_ summonerMenager: SummonerMenager, summoner: Summoner) {
        
        print("--------------")

        summoner.fetchSummonerIcon(completionHandler: { image in
            DispatchQueue.main.async {
                
                self.summonerIcon.image = image
                self.summonerIcon.layer.cornerRadius = self.summonerIcon.frame.size.width / 2
                self.summonerIcon.clipsToBounds = true
                self.summonerNameLabel.text = summoner.name

            }
            
        })
    }

    func didGetError(_ summonerMenager: SummonerMenager, error: Error) {
        print(error) // this is for now
    }


}


