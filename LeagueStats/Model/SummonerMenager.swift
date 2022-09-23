//
//  SummonerMenager.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import Foundation


protocol SummonerMenagerDelegate {
    func didUpdateData(_ summonerMenager:SummonerMenager,summoner:Summoner)
    func didGetError(_ summonerMenager:SummonerMenager,error:Error)
}

struct SummonerMenager {
    
    var apiKey = "RGAPI-3d3dfa11-44a3-4cb9-8086-4c9f28e2e55e"
    var url = "https://eun1.api.riotgames.com/lol/summoner/v4/summoners/by-name"
    
    var delegate:SummonerMenagerDelegate?
    
    
    // MARK: - Fetch Summoner Data
    
    func fetchSummonerData(summonerName:String) {
        
        let urlString = "\(url)/\(summonerName)?api_key=\(apiKey)"

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
        
    }
    
    
    private func decodeJSON(jsonData:Data) -> Summoner?{
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(SummonerJSON.self, from: jsonData)

            return Summoner(id:decodedData.id, accountId:decodedData.accountId, puuid: decodedData.puuid, name: decodedData.name, profileIconId: decodedData.profileIconId, revisionDate: decodedData.revisionDate, summonerLevel: decodedData.summonerLevel)
            
        }catch {
            return nil
        }

        
    }
    
    

}



