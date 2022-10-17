//
//  TestViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 17.10.22..
//

import UIKit

class TestViewController: UIViewController {
    
    let rankedStackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureRankedStackView()
        
        
    }

    func configureRankedStackView(){
        view.addSubview(rankedStackView)
        rankedStackView.axis = .horizontal
        rankedStackView.distribution = .fillEqually
        rankedStackView.spacing = 20
        rankedStackView.backgroundColor = .red
        addRankedDetailsStackView()
        addRankedDetailsStackView()
        setRankedStackViewConstraints()
    }
    
    func addRankedDetailsStackView(){
        let rankedDetails = UIStackView()
        let rankedLabels = UIStackView()
        
        rankedDetails.axis = .vertical
        rankedDetails.distribution = .fill
        rankedDetails.alignment = .center
        rankedDetails.spacing = 0
        
        rankedLabels.axis = .vertical
        rankedLabels.distribution = .fill
        rankedLabels.alignment = .fill
        rankedLabels.spacing = 0
        
        let rankedIcon = UIImageView()
        rankedIcon.image = UIImage(named: "Emblem_Challenger")
        rankedIcon.contentMode = .scaleAspectFit
       
        let rankedTypeLabel = UILabel()
        let rankLabel = UILabel()
        let lpLabel = UILabel()
        let winLossesLabel = UILabel()
        let winRateLabel = UILabel()
        
        rankedTypeLabel.text = "Ranked Solo"
        rankLabel.text = "Silver 3"
        lpLabel.text = "30 LP"
        winLossesLabel.text = "10L 30W"
        winRateLabel.text = "WINRATE 30%"
        
        
        rankedDetails.addArrangedSubview(rankedIcon)
        
        rankedLabels.addArrangedSubview(rankedTypeLabel)
        rankedLabels.addArrangedSubview(rankLabel)
//        rankedLabels.addArrangedSubview(lpLabel)
//        rankedLabels.addArrangedSubview(winLossesLabel)
//        rankedLabels.addArrangedSubview(winRateLabel)
        
        rankedDetails.addArrangedSubview(rankedLabels)
        
        rankedStackView.addArrangedSubview(rankedDetails)
        
        

    }
   
    
    
    func setRankedStackViewConstraints(){
        rankedStackView.translatesAutoresizingMaskIntoConstraints = false
        rankedStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 50).isActive = true
        rankedStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        rankedStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        rankedStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50).isActive = true
    }

   

}
