//
//  MatchDetailsViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 6.10.22..
//

import UIKit

class MatchDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var match:Match?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName:K.detailMatchNibName, bundle:nil), forCellReuseIdentifier: K.detailMatchCellIdentifier)

    }
    
    func gameDuration(for differenceTime:Double) -> String {
        let hours = differenceTime / 3600
        let minutes = hours.truncatingRemainder(dividingBy: 1) * 60
        let seconds = Int(minutes.truncatingRemainder(dividingBy: 1) * 60)
        
        let roundedHours = Int(hours)
        let roundedMinutes = Int(minutes)
        let roundedSeconds = Int(seconds)


        return "\(roundedHours):\(roundedMinutes):\(roundedSeconds)"
    }


}


extension MatchDetailsViewController:UITableViewDelegate {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height:100))
        headerView.backgroundColor = UIColor(named: "HeaderTableViewColor")
        
        let team1Won = match!.participants[0].win
        let team2Won = match!.participants[5].win

        let time = Double((match!.gameEndTimestamp / 1000) - (match!.gameStartTimestamp / 1000)) // seconds
        

        //TODO: STAVITI OVAJ GAME DURATION U HEADER
        
        let gameDuration = gameDuration(for: time)
        
        print(gameDuration)
        
        
        let teamLabel = UILabel()
        teamLabel.font = UIFont(name: "Helvetica Neue", size: 23)
        
        teamLabel.frame = CGRect.init(x: 10, y: 30, width: headerView.frame.width - 10, height: 25)
        if section == 0 {
            
            if team1Won {
                teamLabel.text = "TEAM 1 - Victory"
                headerView.backgroundColor = UIColor(named: "Victory")
            }else {
                teamLabel.text = "TEAM 1 - Defeat"
                headerView.backgroundColor = UIColor(named: "Defeat")
            }
            
        } else {
            if team2Won {
                teamLabel.text = "TEAM 2 - Victory"
                headerView.backgroundColor = UIColor(named: "Victory")
            }else {
                teamLabel.text = "TEAM 2 - Defeat"
                headerView.backgroundColor = UIColor(named: "Defeat")
            }
            
        }
        
        headerView.addSubview(teamLabel)

        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}


extension MatchDetailsViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.detailMatchCellIdentifier, for: indexPath) as! MatchDetailsCustomCell

        var index:Int
        
        if indexPath.section == 0 {
            index = indexPath.row
        }else {
            index = indexPath.row + 5
        }

        cell.item0.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item0).png"))
        cell.item1.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item1).png"))
        cell.item2.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item2).png"))
        cell.item3.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item3).png"))
        cell.item4.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item4).png"))
        cell.item5.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item5).png"))
        cell.item6.kf.setImage(with: URL(string:"\(K.itemURL)\(match!.participants[index].item6).png"))
    
                
        cell.championIcon.kf.setImage(with: URL(string:"\(K.summonerIconURL)\(match!.participants[index].championName).png"))
        
        cell.championLevel.text = "\(match!.participants[index].champLevel)"
        
        cell.killsLabel.text = "\(match!.participants[index].kills)"
        cell.deathsLabel.text = "\(match!.participants[index].deaths)"
        cell.assitsLabel.text = "\(match!.participants[index].assists)"
        
        cell.minionsKilled.text = "\(match!.participants[index].totalMinionsKilled)"
        
        let numFormatter = NumberFormatter()
        numFormatter.numberStyle = .decimal
        
        let goldEarned = match!.participants[index].goldEarned
        let goldEarnedFormatted = numFormatter.string(from: NSNumber(value:goldEarned))
        
        cell.goldEarned.text = "\(goldEarnedFormatted!)"
            
        cell.summonerSpell1.kf.setImage(with: URL(string: "\(K.summonerSpellURL)\(match!.participants[index].summonerSpell1).png"))
        cell.summonerSpell2.kf.setImage(with: URL(string: "\(K.summonerSpellURL)\(match!.participants[index].summonerSpell2).png"))
        
        
        return cell
    }
    
    
}
