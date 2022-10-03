//
//  SummonerJSON.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//



struct SummonerJSON:Codable{
    
    let id:String
    let accountId:String
    let puuid:String
    let name:String
    let profileIconId:Int
    let summonerLevel:Int
    
}
