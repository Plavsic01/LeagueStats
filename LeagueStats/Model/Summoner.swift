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
    let summonerLevel:Int

        
}


struct SummonerRanked {
    
    let queueType:String
    let tier:String
    let rank:String
    let leaguePoints:String
    let wins:Int
    let losses:Int
    
    var winRate:String {
        var
        winRate = Double(wins) / Double((wins+losses))
        winRate *= 100
        return "Win Rate \(Int(winRate.rounded()) )%"
    }
    
    var winsAndLosses:String {
        return "\(wins)W \(losses)L"
    }
    var soloQRank:String {
        return rankImg(queueType: queueType, tier: tier)
    }
    
    var flexRank:String {
        return rankImg(queueType: queueType, tier: tier)
    }
    
    
    private func rankImg(queueType:String,tier:String) -> String {
        
        var imgName:String?
        
        switch(tier) {
        case "IRON":
            imgName = "Emblem_Iron"
        case "BRONZE":
            imgName = "Emblem_Bronze"
        case "SILVER":
            imgName = "Emblem_Silver"
        case "GOLD":
            imgName = "Emblem_Gold"
        case "PLATINUM":
            imgName = "Emblem_Platinum"
        case "DIAMOND":
            imgName = "Emblem_Diamond"
        case "MASTER":
            imgName = "Emblem_Master"
        case "GRANDMASTER":
            imgName = "Emblem_Grandmaster"
        case "CHALLENGER":
            imgName = "Emblem_Challenger"
        default:
            imgName = ""
        }
        
        if queueType == "RANKED_SOLO_5x5" {
            return imgName!
            
        } else if queueType == "RANKED_FLEX_SR" {
            return imgName!
        }
        
        return ""
    }

}
