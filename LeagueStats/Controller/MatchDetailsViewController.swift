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
        // Do any additional setup after loading the view.
        
    }


}


extension MatchDetailsViewController:UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height:100))
        headerView.backgroundColor = UIColor(named: "HeaderTableViewColor")
        
        let label = UILabel()
        label.frame = CGRect.init(x: 10, y: 30, width: headerView.frame.width - 10, height: 20)
        if section == 0 {
            label.text = "TEAM 1"
        }else {
            label.text = "TEAM 2"
        }
        
        headerView.addSubview(label)
        
        
        
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
        
        
        
        cell.killsLabel.text = "\(match!.participants[index].kills)"
        cell.deathsLabel.text = "\(match!.participants[index].deaths)"
        cell.assitsLabel.text = "\(match!.participants[index].assists)"
        
        cell.minionsKilled.text = "\(match!.participants[index].totalMinionsKilled)"
        cell.goldEarned.text = "\(match!.participants[index].goldEarned)"
            
        
        
        
        return cell
    }
    
    
}
