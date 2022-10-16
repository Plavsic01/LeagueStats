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
//    var ranked:[SummonerRanked]?
    
    
//    init(id:String,accountId:String,puuid:String,name:String,profileIconId:Int,summonerLevel:Int){
//        self.id = id
//        self.accountId = accountId
//        self.puuid = puuid
//        self.name = name
//        self.profileIconId = profileIconId
//        self.summonerLevel = summonerLevel
//    }
        
}


// neki princip enuma za koji rank koju sliku staviti

// vrv ovo sve treba biti optional zato sto je moguce da ne postoji

struct SummonerRanked {
    
    let queueType:String
    let tier:String
    let rank:String
    let leaguePoints:String
    let wins:String
    let losses:String
    
//    init(queueType:String,tier:String,rank:String,leaguePoints:String,wins:String,losses:String){
//        self.queueType = queueType
//        self.tier = tier
//        self.rank = rank
//        self.leaguePoints = leaguePoints
//        self.wins = wins
//        self.losses = losses
//    }
    
}
