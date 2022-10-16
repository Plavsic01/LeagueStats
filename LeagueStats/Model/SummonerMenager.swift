//
//  SummonerMenager.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import Foundation
import SwiftyJSON


protocol SummonerMenagerDelegate:AnyObject {
    func didUpdateData(_ summonerMenager:SummonerMenager,summoner:Summoner)
    func didGetError(_ summonerMenager:SummonerMenager,error:Error)
}

struct SummonerMenager {
    
    weak var delegate:SummonerMenagerDelegate?
    
    
    // MARK: - Fetch Summoner Data
    
    func fetchSummonerData(summonerName:String) {
        
            
        if NetworkConnectivity.shared.isReachable {
        
            let urlString = "\(K.summonerURL)/\(summonerName)?api_key=\(K.api_key)"

            if let url = URL(string: urlString) {
                
                let session = URLSession.shared
                
                let request = URLRequest(url: url)
                
                let dataTask = session.dataTask(with: request) { data, _, error in
                    if let safeData = data {
                        
                        let currentSummoner = decodeJSON(jsonData: safeData)!

                        delegate?.didUpdateData(self, summoner: currentSummoner)
                        
                    }else {
                        
                        delegate?.didGetError(self, error: error!)
                        
                    }
                }
             
                dataTask.resume()
            }
        
        } //else{
//            print("no connection")
//        }
    
}
    
    
    private func decodeJSON(jsonData:Data) -> Summoner?{
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SummonerJSON.self, from: jsonData)

            return Summoner(id:decodedData.id, accountId:decodedData.accountId, puuid: decodedData.puuid, name: decodedData.name, profileIconId: decodedData.profileIconId, summonerLevel: decodedData.summonerLevel)
            
        }catch {
            return nil
        }

        
    }
    
    
    
    // MARK: - Fetch Summoner's Ranked data
    
    func fetchRankedData(summonerId:String,completionHandler:@escaping ([SummonerRanked]) -> Void){
        let urlString = "\(K.summonerRankedURL)\(summonerId)?api_key=\(K.api_key)"
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let request = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: request) { data, _, error in
                if let safeData = data {
                    
                    do {
                        
                        let json = try JSON(data: safeData)
                        
                        var rankedArray:[SummonerRanked] = []
                        
                        for i in 0..<json.count {
                            
                            let queueType = json[i]["queueType"].rawString()!
                            let tier = json[i]["tier"].rawString()!
                            let rank = json[i]["rank"].rawString()!
                            let wins =  json[i]["wins"].rawString()!
                            let losses = json[i]["losses"].rawString()!
                            let points = json[i]["leaguePoints"].rawString()!
                            
                            let summonerRanked = SummonerRanked(queueType: queueType, tier: tier, rank: rank, leaguePoints: points, wins: wins, losses: losses)
                            
                            rankedArray.append(summonerRanked)
                        }
                        
                        completionHandler(rankedArray)

                        
                        
                    } catch {
                        
                    }
                
    
                    
                    
                }else {
                
                    print(error!.localizedDescription)
                }
            }
         
            dataTask.resume()
        }
    }
    
    

}



