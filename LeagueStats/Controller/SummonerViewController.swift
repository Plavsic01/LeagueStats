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
    
    private var summonerManager = SummonerMenager()
    private var matchManager = MatchMananger()
    
    let refreshControl = UIRefreshControl()
    
    private var matchArray:[Match] = []

    var searchResult:String?
    var matchDetails:Match?
    
    
    deinit {
        print("oslobodjena memorija za klasu SummonerViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName:K.nibName, bundle:nil), forCellReuseIdentifier: K.cellIdentifier)
        summonerManager.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        summonerManager.fetchSummonerData(summonerName: searchResult!)
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    
    }
    
    @objc func refresh(_ sender:AnyObject) {

        DispatchQueue.main.async {
            self.matchArray.removeAll()
            self.tableView.reloadData()
        }
        summonerManager.fetchSummonerData(summonerName: searchResult!)
        refreshControl.endRefreshing()
    }
    
   
    // Sends specific match selected from table view to MatchDetailsViewController
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destionationVC = segue.destination as? MatchDetailsViewController {
            destionationVC.match = matchDetails
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

        
        // Download and display item images from every match played
        
        // If match is won display background color -> Blue else -> Red
        if sortedArray[indexPath.section].participant.win {
            cell.backgroundColor = UIColor(named: "Victory")

        }else{
            cell.backgroundColor = UIColor(named: "Defeat")
        }
        
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
            
        }
    }

    func didUpdateData(_ summonerMenager: SummonerMenager, summoner: Summoner) {


        // Fetch matches and append them into matchArray and reload table view
        
        matchManager.fetchMatches(summoner:summoner,count: 20) { [weak self] match in
            DispatchQueue.main.async {
                self?.matchArray.append(match)
                self?.tableView.reloadData()
            }
        }
        
        // Fetch Summoner icon
        
        fetchSummonerIcon(summoner: summoner)
        
    }
        
        
    
    func didGetError(_ summonerMenager: SummonerMenager, error: Error) {
        print(error) // this is for now
    }
    
}

    









                                
