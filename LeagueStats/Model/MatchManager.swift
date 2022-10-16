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

    
    
    func fetchMatches(summoner:Summoner,count:Int,completionHandler:@escaping(Match?,Int?) -> Void){
        
        if NetworkConnectivity.shared.isReachable {
        
            let url = URL(string: "\(K.fetchMatchesURL)\(summoner.puuid)/ids?start=0&count=\(count)&api_key=\(K.api_key)")!
                
            
            AF.request(url).validate().responseData { data in
                
                
                
                if let safeData = data.data {
                    do {
                        let json = try JSON(data: safeData)
//                        print(json)

                        for i in 0..<count {
                            
                            fetchMatch(summoner:summoner,matchId: json[i].rawString()!) { match,statusCode in
                                
                                if statusCode == nil {
                                    completionHandler(match!,nil)
                                }else {
                                    completionHandler(nil,statusCode)
                                }
                                
                            }
                            
                        }
                    }catch {
                        print(error.localizedDescription)
                        
                    }
                    
                }
            }
    
    }
}
    
    
    private func fetchMatch(summoner:Summoner,matchId:String,completionHandler:@escaping(Match?,Int?) -> Void){
        
        let url = URL(string:"\(K.matchURL)\(matchId)?api_key=\(K.api_key)")!
        
        AF.request(url).validate().responseData { match in
            
            if match.response!.statusCode == 200 {
                
                if let safeData = match.data {
    
                    do {
                
                        var participants:[Participant] = []
                        
                        let json = try JSON(data: safeData)
                        
                        let gameCreation = json["info"]["gameCreation"].rawValue as! Int
                        let gameDuration = json["info"]["gameDuration"].rawValue as! Int
                        let gameStartTimestamp = json["info"]["gameStartTimestamp"].rawValue as! Int
                        let gameEndTimestamp = json["info"]["gameEndTimestamp"].rawValue as! Int
                        
                        for participant in json["info"]["participants"] {
                            
                            let summonerName = participant.1["summonerName"].rawString()!
                            let champLevel = participant.1["champLevel"].rawValue as! Int
                            let championName = participant.1["championName"].rawString()!
                            
                            let summoner1Id = participant.1["summoner1Id"].rawValue as! Int
                            let summoner2Id = participant.1["summoner2Id"].rawValue as! Int
                            
                            let kills = participant.1["kills"].rawValue as! Int
                            let deaths = participant.1["deaths"].rawValue as! Int
                            let assists = participant.1["assists"].rawValue as! Int
                            
                            let goldEarned = participant.1["goldEarned"].rawValue as! Int
                            var totalMinionsKilled = participant.1["totalMinionsKilled"].rawValue as! Int
                            let neutralMinionsKilled = participant.1["neutralMinionsKilled"].rawValue as! Int
                            
                            totalMinionsKilled = totalMinionsKilled + neutralMinionsKilled
                            
                            let item0 = participant.1["item0"].rawValue as! Int
                            let item1 = participant.1["item1"].rawValue as! Int
                            let item2 = participant.1["item2"].rawValue as! Int
                            let item3 = participant.1["item3"].rawValue as! Int
                            let item4 = participant.1["item4"].rawValue as! Int
                            let item5 = participant.1["item5"].rawValue as! Int
                            let item6 = participant.1["item6"].rawValue as! Int
                            
                            let win = participant.1["win"].rawValue as! Bool
                            
                            let participant = Participant(summonerName: summonerName, champLevel: champLevel, championName: championName, kills: kills, deaths: deaths,assists: assists,goldEarned: goldEarned,totalMinionsKilled: totalMinionsKilled,summoner1Id: summoner1Id,summoner2Id: summoner2Id,item0: item0, item1: item1, item2: item2, item3: item3, item4: item4, item5: item5, item6: item6, win: win)
                            
                            participants.append(participant)
                        }
                        
                        let match = Match(gameCreation:gameCreation, gameDuration: gameDuration,gameStartTimestamp: gameStartTimestamp,gameEndTimestamp: gameEndTimestamp, summoner:summoner,participants: participants)
                        completionHandler(match,nil)
                    } catch {
                        print(error.localizedDescription)
                        
                    }
                }
                
            } else {
                completionHandler(nil,match.response!.statusCode)
            }
            
        }
    }
    
    
}
