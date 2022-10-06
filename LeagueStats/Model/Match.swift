//
//  Match.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 24.9.22..
//

import Foundation
import Kingfisher
import UIKit


struct Match {
    let gameCreation:Int
    let gameDuration:Int
    let summoner:Summoner
    let participants:[Participant]
    
    /*
     Participant is a computed property and returns participant who is being searched for match history
     E.g. I search for AtarioVanix and participants array will return all 10 players in the match
     but the participant is going to be Participant object with data associated with AtarioVanix
     */
    
    var participant:Participant {
        var player:Participant?
        for participant in participants {
            if summoner.name == participant.summonerName {
                player = participant
            }
        }
        return player!
    }
    

}

struct Participant {
    let summonerName:String
    let champLevel:Int
    let championName:String
    let kills:Int
    let deaths:Int
    let assists:Int
    let goldEarned:Int
    let totalMinionsKilled:Int
    
    let item0:Int
    let item1:Int
    let item2:Int
    let item3:Int
    let item4:Int
    let item5:Int
    let item6:Int // ward
    
    let win:Bool
}
