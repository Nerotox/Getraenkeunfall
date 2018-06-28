//
//  HomeViewController.swift
//  Gertränkeunfall
//
//  Created by Alexander Karrer on 20.04.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import UIKit
import Foundation

class HomeViewController: UIViewController {
    
    var rulesHaveBeenRead = false
    var rules: Rules?
    let segueIdentifier = "home"

    @IBOutlet weak var instagramImageView: UIImageView!
    @IBOutlet weak var twitterImageView: UIImageView!
    @IBOutlet weak var facebookImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if rulesHaveBeenRead == false {
            rules = Rules()
            readRules()
        }
        instagramImageView.isUserInteractionEnabled = true
        twitterImageView.isUserInteractionEnabled = true
        facebookImageView.isUserInteractionEnabled = true
        let instaGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.instaClicked(_:)))
        instagramImageView.addGestureRecognizer(instaGestureRecogniser)
        let facebookGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.facebookClicked(_:)))
        facebookImageView.addGestureRecognizer(facebookGestureRecogniser)
        let twitterGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(self.twitterClicked(_:)))
        twitterImageView.addGestureRecognizer(twitterGestureRecogniser)
    }
    
    @objc func instaClicked(_ sender: AnyObject){
        UIApplication.shared.open(URL(string: "http://www.instagram.com")!, options: [:])
    }
    
    @objc func facebookClicked(_ sender: AnyObject){
        UIApplication.shared.open(URL(string: "http://www.facebook.com")!, options: [:])
    }
    
    @objc func twitterClicked(_ sender: AnyObject){
        UIApplication.shared.open(URL(string: "http://www.twitter.com")!, options: [:])
    }
    
    //reads the rules from the provided csv and categorises them.
    func readRules(){
        let path = Bundle.main.path(forResource: "Getraenkeunfall_Rules", ofType: "csv")
        let data = try? String(contentsOfFile: path!, encoding: String.Encoding.isoLatin2)
       // print(data!)
        
        var lines: [String] = []
        data!.enumerateLines { line, _ in lines.append(line)}
        
        for lin in lines {
            if lin.starts(with: "#") != true {
                switch lin.first {
                case "G":
                    var splittedRule = lin.split(separator: ";")
                    if !String(splittedRule[1]).starts(with: "#") {
                        rules!.rulesGeneral[String(splittedRule[0])] = String(splittedRule[1])
                    }
                case "1":
                    switch lin[lin.index(lin.startIndex, offsetBy: 1)] {
                    case "P":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            rules!.onePlayerGame[String(splittedRule[0])] = String(splittedRule[1])
                        }
                    case "R":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            rules!.onePlayerRuleGameRule[String(splittedRule[0])] = String(splittedRule[1])
                            rules!.onePlayerRuleGameResolve[String(splittedRule[0])] = String(splittedRule[2])
                        }
                    default:
                        print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                    }
                case "2":
                    switch lin[lin.index(lin.startIndex, offsetBy: 1)] {
                    case "P":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            rules!.twoPlayerGame[String(splittedRule[0])] = String(splittedRule[1])
                        }
                    case "R":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            rules!.twoPlayerRuleGameRule[String(splittedRule[0])] = String(splittedRule[1])
                            rules!.twoPlayerRuleGameResolve[String(splittedRule[0])] = String(splittedRule[2])
                        }
                    default:
                        print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                    }
                case "3":
                    switch lin[lin.index(lin.startIndex, offsetBy: 1)] {
                    case "P":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            rules!.threePlayerGame[String(splittedRule[0])] = String(splittedRule[1])
                        }
                    case "R":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            rules!.threePlayerRuleGameRule[String(splittedRule[0])] = String(splittedRule[1])
                            rules!.threePlayerRuleGameResolve[String(splittedRule[0])] = String(splittedRule[2])
                        }
                    default:
                        print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                    }
                default:
                    print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                }
            }
        }
        rulesHaveBeenRead = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is AddPlayersViewController{
            let dest = segue.destination as? AddPlayersViewController
            dest?.rules = rules
            dest?.previousSegueIdentifier = segueIdentifier
        }
    }
}
