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
    
    var rulesGeneral: Dictionary<String, String> = [:]
    var onePlayerGame: Dictionary<String, String> = [:]
    var twoPlayerGame: Dictionary<String, String> = [:]
    var threePlayerGame: Dictionary<String, String> = [:]
    var onePlayerRuleGameRule: Dictionary<String, String> = [:]
    var onePlayerRuleGameResolve: Dictionary<String, String> = [:]
    var twoPlayerRuleGameRule: Dictionary<String, String> = [:]
    var twoPlayerRuleGameResolve: Dictionary<String, String> = [:]
    var threePlayerRuleGameRule: Dictionary<String, String> = [:]
    var threePlayerRuleGameResolve: Dictionary<String, String> = [:]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if rulesHaveBeenRead == false {
            readRules()
        }
        
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
                        rulesGeneral[String(splittedRule[0])] = String(splittedRule[1])
                    }
                case "1":
                    switch lin[lin.index(lin.startIndex, offsetBy: 1)] {
                    case "P":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            onePlayerGame[String(splittedRule[0])] = String(splittedRule[1])
                        }
                    case "R":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            onePlayerRuleGameRule[String(splittedRule[0])] = String(splittedRule[1])
                            onePlayerRuleGameResolve[String(splittedRule[0])] = String(splittedRule[2])
                        }
                    default:
                        print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                    }
                case "2":
                    switch lin[lin.index(lin.startIndex, offsetBy: 1)] {
                    case "P":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            twoPlayerGame[String(splittedRule[0])] = String(splittedRule[1])
                        }
                    case "R":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            twoPlayerRuleGameRule[String(splittedRule[0])] = String(splittedRule[1])
                            twoPlayerRuleGameResolve[String(splittedRule[0])] = String(splittedRule[2])
                        }
                    default:
                        print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                    }
                case "3":
                    switch lin[lin.index(lin.startIndex, offsetBy: 1)] {
                    case "P":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            threePlayerGame[String(splittedRule[0])] = String(splittedRule[1])
                        }
                    case "G":
                        var splittedRule = lin.split(separator: ";")
                        if !String(splittedRule[1]).starts(with: "#") {
                            threePlayerRuleGameRule[String(splittedRule[0])] = String(splittedRule[1])
                            threePlayerRuleGameResolve[String(splittedRule[0])] = String(splittedRule[2])
                        }
                    default:
                        print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                    }
                default:
                    print("Rule \(lin) could not be assigned to a Category. Make sure there is no Spelling Error in the ID." )
                }
            }
        }
        print("Testing Rules General")
        print(onePlayerGame)
        
        rulesHaveBeenRead = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is OptionsViewController{
            //let destvc = segue.destination as? OptionsViewController
            //destvc?.selectedDifficulty = self.selectedDifficulty
        }
    }
}
