//
//  Constants.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 24.9.22..
//

import Foundation


struct K {
    
    static let api_key = "RGAPI-455b8388-a653-4a2d-8c68-e82c472934a0"
    static let summonerURL = "https://eun1.api.riotgames.com/lol/summoner/v4/summoners/by-name" // get summoner by name
    static let fetchMatchesURL = "https://europe.api.riotgames.com/lol/match/v5/matches/by-puuid/" // get match list
    static let matchURL = "https://europe.api.riotgames.com/lol/match/v5/matches/" // get specific match
    static let summonerSpellURL = "https://ddragon.leagueoflegends.com/cdn/12.19.1/img/spell/"
    
    static let cellIdentifier = "matchCell"
    static let nibName = "MatchCustomCell"
    
    static let detailMatchCellIdentifier = "detailMatchCell"
    static let detailMatchNibName = "MatchDetailsCustomCell"
    
    static let summonerViewControllerSegue = "searchSegue"
    static let matchDetailsViewControllerSegue = "showDetails"
    
    static let itemURL = "https://ddragon.leagueoflegends.com/cdn/12.18.1/img/item/"
    static let summonerIconURL = "https://ddragon.leagueoflegends.com/cdn/12.18.1/img/champion/"
    
}
