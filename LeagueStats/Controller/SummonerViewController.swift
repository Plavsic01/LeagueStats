//
//  SummonerViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import UIKit
import Kingfisher

class SummonerViewController: UIViewController {
    
    @IBOutlet weak var summonerNameLabel: UILabel!
    @IBOutlet weak var summonerLevelLabel: UILabel!
    @IBOutlet weak var summonerIcon: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rankedDetails: UIButton!
    
    private var summonerManager = SummonerMenager()
    private var matchManager = MatchMananger()
    
    let refreshControl = UIRefreshControl()
    
    private var matchArray:[Match] = []

    var searchResult:String?
    var summoner:Summoner?
    var matchDetails:Match?
    var errorOccured = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:K.nibName, bundle:nil), forCellReuseIdentifier: K.cellIdentifier)
        summonerManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        summonerManager.fetchSummonerData(summonerName: searchResult!)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        rankedDetails.isHidden = true
        
    
    }
    
    @objc func refresh(_ sender:AnyObject) {
        
        DispatchQueue.main.async {
            self.matchArray.removeAll()
            self.tableView.reloadData()
        }
        self.errorOccured = false

        summonerManager.fetchSummonerData(summonerName: searchResult!)
                
        refreshControl.endRefreshing()
    }
    
   
    // Sends specific match selected from table view to MatchDetailsViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.matchDetailsViewControllerSegue {
            if let destionationVC = segue.destination as? MatchDetailsViewController {
                destionationVC.match = matchDetails
            }
        }else if segue.identifier == K.rankedDetailsViewControllerSegue {
            if let destionationVC = segue.destination as? RankedDetailsViewController {
                destionationVC.summoner = summoner
            }
        }
        
    }

}

// MARK: - TableViewDelegate and TableViewDataSource

extension SummonerViewController:UITableViewDelegate,UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return matchArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MatchCustomCell
        
        
        /*
         Sort matchArray so that json results come from newest to oldest,
         because we need to have data sorted from newest game played to the oldest
         */
        
        let sortedArray =  matchArray.sorted(by:{$0.gameCreation > $1.gameCreation})
        
        // Fetch items with Kingfisher and display them into table view
        cell.image1.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item0).png"))
        cell.image2.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item1).png"))
        cell.image3.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item2).png"))
        cell.image4.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item3).png"))
        cell.image5.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item4).png"))
        cell.image6.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item5).png"))
        cell.image7.kf.setImage(with: URL(string:"\(K.itemURL)\(sortedArray[indexPath.section].participant.item6).png"))

        // Fetch champion icon with Kingfisher and display into table view
        cell.championIcon.kf.setImage(with: URL(string:"\(K.summonerIconURL)\(sortedArray[indexPath.section].participant.championName).png"))

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(3.0)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(3.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sortedArray =  matchArray.sorted(by:{$0.gameCreation > $1.gameCreation})
        matchDetails = sortedArray[indexPath.section]
        performSegue(withIdentifier: K.matchDetailsViewControllerSegue, sender: self)
    }
    
}


// MARK: - SummonerManagerDelegate

extension SummonerViewController:SummonerMenagerDelegate {
    

    private func fetchSummonerIcon(summoner:Summoner){
        DispatchQueue.main.async {
            self.summonerIcon.kf.setImage(with: URL(string: "\(summoner.profileIconUrl)"))
            self.summonerIcon.layer.cornerRadius = self.summonerIcon.frame.size.width / 2
            self.summonerIcon.clipsToBounds = true
            self.summonerNameLabel.text = summoner.name
            self.summonerLevelLabel.text = "\(summoner.summonerLevel)"
            self.rankedDetails.isHidden = false
            
        }
    }

    func didUpdateData(_ summonerMenager: SummonerMenager,  summoner: Summoner) {

        self.summoner = summoner
        
        // Fetch matches and append them into matchArray and reload table view
        matchManager.fetchMatches(summoner:summoner,count: 20) { [weak self] match,statusCode in
            
            if statusCode == nil {
                DispatchQueue.main.async {
                    self?.matchArray.append(match!)
                    self?.tableView.reloadData()
                }
            }else {
                
                // If statement is here because we don't want repetition of same Alert Controller
                // This closure loops 20 times but only once shows alert
                
                if !self!.errorOccured {
                    
                    // technically statusCode is 200 because status is OK but json returns 0 values
                    // because there are no matches played in a while.
                    
                    if statusCode == 404 {
                        self!.tableView.isHidden = true
                    }else {
                        let alert = UIAlertController(title: "Error \(statusCode!)", message: "Error occured, Please try in few minutes.", preferredStyle: UIAlertController.Style.alert)
                        
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.destructive))
                        self?.present(alert, animated: true, completion: nil)
                        
                        self!.errorOccured = true
                    }
                    
                    
                }
        
            }
            
        }
        
        // Fetch Summoner icon
        fetchSummonerIcon(summoner: summoner)
        
    }
      
    
    func didGetError(_ summonerMenager: SummonerMenager, error: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { alertAction in
                self.navigationController?.popViewController(animated: true)
            }
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
            
        }
        
        
        
        
    }
    
}

    









                                
