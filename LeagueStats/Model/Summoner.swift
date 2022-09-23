//
//  Summoner.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import Foundation


struct Summoner {
    
    let id:String
    let accountId:String
    let puuid:String
    let name:String
    let profileIconId:Int
    let revisionDate:Int // date summoner was updated last time. Following events update timestamp: summoner name change, summoner level change or profile icon change 
    let summonerLevel:Int

    
}
