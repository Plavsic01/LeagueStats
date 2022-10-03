//
//  MatchManager.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 24.9.22..
//

import Foundation
import Alamofire
import SwiftyJSON

struct MatchMananger {

    
    func fetchMatches(summoner:Summoner,count:Int,completionHandler:@escaping(Match) -> Void){
        
        let url = URL(string: "\(K.fetchMatchesURL)\(summoner.puuid)/ids?start=0&count=\(count)&api_key=\(K.api_key)")!
                      
        AF.request(url).validate().responseData { data in
            if let safeData = data.data {
                do {
                    let json = try JSON(data: safeData)

                    for i in 0..<count {
                        
                        fetchMatch(summoner:summoner,matchId: json[i].rawString()!) { match in
                            completionHandler(match)
                        }

                    }
                }catch {
                    print(error.localizedDescription)
                }
                
            }
        }
        
        
    }
    
    
    private func fetchMatch(summoner:Summoner,matchId:String,completionHandler:@escaping(Match) -> Void){
        
        let url = URL(string:"\(K.matchURL)\(matchId)?api_key=\(K.api_key)")!
        
        AF.request(url).validate().responseData { match in
            if let safeData = match.data {
                do {
            
                    var participants:[Participant] = []
                    
                    let json = try JSON(data: safeData)
                    let gameCreation = json["info"]["gameCreation"].rawValue as! Int
                    let gameDuration = json["info"]["gameDuration"].rawValue as! Int
                    
                    for participant in json["info"]["participants"] {
                        
                        let summonerName = participant.1["summonerName"].rawString()!
                        let champLevel = participant.1["champLevel"].rawValue as! Int
                        let championName = participant.1["championName"].rawString()!
                        
                        let kills = participant.1["kills"].rawValue as! Int
                        let deaths = participant.1["deaths"].rawValue as! Int
                        let lane = participant.1["lane"].rawString()!
                        let goldEarned = participant.1["goldEarned"].rawValue as! Int
                        
                        let item0 = participant.1["item0"].rawValue as! Int
                        let item1 = participant.1["item1"].rawValue as! Int
                        let item2 = participant.1["item2"].rawValue as! Int
                        let item3 = participant.1["item3"].rawValue as! Int
                        let item4 = participant.1["item4"].rawValue as! Int
                        let item5 = participant.1["item5"].rawValue as! Int
                        let item6 = participant.1["item6"].rawValue as! Int
                        
                        let win = participant.1["win"].rawValue as! Bool
                        
                        let participant = Participant(summonerName: summonerName, champLevel: champLevel, championName: championName, kills: kills, deaths: deaths, lane: lane, goldEarned: goldEarned, item0: item0, item1: item1, item2: item2, item3: item3, item4: item4, item5: item5, item6: item6, win: win)
                        
                        participants.append(participant)
                    }
                    
                    let match = Match(gameCreation:gameCreation, gameDuration: gameDuration, summoner:summoner,participants: participants)
                    completionHandler(match)
                }catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
  

    
    
    
    
}
