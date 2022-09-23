//
//  Summoner.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import Foundation
import UIKit


struct Summoner {
    
    let id:String
    let accountId:String
    let puuid:String
    let name:String
    let profileIconId:Int
    var profileIconUrl:String {
        return "https://ddragon.leagueoflegends.com/cdn/12.18.1/img/profileicon/\(profileIconId).png"
    }
    let revisionDate:Int // date summoner was updated last time. Following events update timestamp: summoner name change, summoner level change or profile icon change 
    let summonerLevel:Int

    
    
    // MARK: - Fetch Summoner Icon
    
    func fetchSummonerIcon(completionHandler:@escaping (UIImage) -> Void)  {
        let url = URL(string: profileIconUrl)!
        print(url)
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            let image = UIImage(data: data!)!
            completionHandler(image)
        }
        
    }
    
    
}
