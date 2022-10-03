//
//  MatchManager.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 24.9.22..
//

import Foundation


struct MatchMananger {

    
    // MARK: - Fetch array of matchIds
    
    func fetchMatchArray(puuid:String,completionHandler:@escaping ([String]) -> Void) {
        let urlString = "\(K.fetchMatchesURL)\(puuid)/ids?start=0&count=20&api_key=\(K.api_key)"
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let request = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: request) { data, _, error in
                if let safeData = data {
                    let results = decodeMatchArray(data: safeData)
                    completionHandler(results)
                }else {
                    print(error!.localizedDescription)
                }
            }
            
            dataTask.resume()
        }
    }
    
    
    
    
    // MARK: - Decode data array of match Ids
    
    private func decodeMatchArray(data:Data) -> [String]{
        do{
            let matchIds = try JSONSerialization.jsonObject(with: data) as! [String]
            return matchIds

        }catch {
            print(error.localizedDescription)
            return []
        }
        
    }
    
    
    
    
    
    
    // MARK: - Fetch data for specific match by matchId
    
    func fetchMatchData(matchId:String,summoner:Summoner,completionHandler:@escaping (Match) -> Void) {
        
        
        let urlString = "\(K.matchURL)\(matchId)?api_key=\(K.api_key)"
        
        
        if let url = URL(string: urlString) {
            
            let session = URLSession.shared
            
            let request = URLRequest(url: url)
            
            let dataTask = session.dataTask(with: request) { data, _, error in
                if let safeData = data {
                    let match = decodeMatchData(summoner:summoner,data:safeData)!
                    completionHandler(match)
                    
                }else {
                    print(error!.localizedDescription)
                }
            }
            
            dataTask.resume()
        }
        
        
    }
    
    
    
    
    // MARK: - Decode specific match data
    
    private func decodeMatchData(summoner:Summoner,data:Data) -> Match?{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            print(data)
            let decodedData = try decoder.decode(MatchJSON.self, from: data)
            
            let match = Match(gameCreation: decodedData.info.gameCreation,gameDuration:decodedData.info.gameDuration,gameMode: decodedData.info.gameMode, mapId: decodedData.info.mapId, summoner: summoner, participants: decodedData.info.participants)
        
            return match
            
        }catch {
            print(error.localizedDescription)

            return nil
        }
    }

    
    
    
    
}
