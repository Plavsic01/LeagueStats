//
//  MatchJSON.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 24.9.22..
//

import Foundation

struct MatchJSON:Codable {
    
    let info:Info
}


struct Info:Codable {
    let gameCreation:Int
    let gameDuration:Int
    let gameMode:String
    let mapId:Int
    let participants:[Participant]
    
}



struct Participant:Codable {
    let summonerName:String
    let champLevel:Int
    let championName:String
    let kills:Int
    let deaths:Int
    let lane:String
    let goldEarned:Int
    
    let item0:Int
    let item1:Int
    let item2:Int
    let item3:Int
    let item4:Int
    let item5:Int
    let item6:Int // ward
    
    let win:Bool
}
