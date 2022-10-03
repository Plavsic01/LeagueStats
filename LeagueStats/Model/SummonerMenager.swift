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
    
    var delegate:SummonerMenagerDelegate?
    
    
    // MARK: - Fetch Summoner Data
    
    func fetchSummonerData(summonerName:String) {
        
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
    
    

}



