//
//  ViewController.swift
//  LeagueStats
//
//  Created by Andrej Plavsic on 23.9.22..
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    

    override func viewWillAppear(_ animated: Bool) {
        searchButton.layer.cornerRadius = 5
        searchButton.layer.borderWidth = 1
        searchButton.layer.borderColor = CGColor(srgbRed: 255, green: 255, blue: 255, alpha: 1.0)
        
        inputField.layer.cornerRadius = 5
        inputField.layer.borderWidth = 1
        inputField.layer.borderColor = CGColor(srgbRed: 255, green: 255, blue: 255, alpha: 1.0)
        
        inputField.attributedPlaceholder = NSAttributedString(string: "Enter your Summoner Name", attributes: [NSAttributedString.Key.foregroundColor:UIColor.white.withAlphaComponent(0.6)])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputField.delegate = self
        
        if inputField.text!.isEmpty {
            searchButton.isUserInteractionEnabled = false
            searchButton.alpha = 0.5
        }

        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.summonerViewControllerSegue {
            let destionationVC = segue.destination as! SummonerViewController
            destionationVC.searchResult = inputField.text
        }
    }
    

}



extension ViewController:UITextFieldDelegate {
    
    // This function listens for every character written in textField
    // Creates new string in range with each character combined
    // Check if new string is empty -> disable button and set opacity to .5
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        
        let text = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if text.isEmpty {
            searchButton.isUserInteractionEnabled = false
            searchButton.alpha = 0.5
        }else {
            searchButton.isUserInteractionEnabled = true
            searchButton.alpha = 1.0
        }
        return true
    }
    
}




