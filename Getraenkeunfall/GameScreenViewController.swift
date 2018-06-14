//
//  GameScreenViewController.swift
//  Getraenkeunfall
//
//  Created by Alexander Karrer on 13.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import UIKit

class GameScreenViewController: UIViewController {
    
    var rules: Rules?
    var players: [String]?
    var roleGamesCurrentlyInPlay: Dictionary<String, Int> = [:]
    var roleGamesSolutionInPlay: Dictionary<String, String> = [:]
    
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet var gameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.nextRule))
        self.gameView.addGestureRecognizer(gesture)
        ruleLabel.text = getNextRule()
    }

    @objc func nextRule(sender : UITapGestureRecognizer) {
        let rule = getNextRule()
        ruleLabel.text = getPlayableRule(rule: rule)
    }
    func getPlayableRule(rule:String) -> String {
        return rule
    }
    
    func getNextRule() -> String {
        for role in roleGamesCurrentlyInPlay {
            if role.value == 0 {
                let solution = roleGamesSolutionInPlay[role.key]!
                roleGamesSolutionInPlay.removeValue(forKey: role.key)
                roleGamesCurrentlyInPlay.removeValue(forKey: role.key)
                return solution
            }
            roleGamesCurrentlyInPlay[role.key] = role.value - 1
        }
        let random = arc4random_uniform(10) + 1;
        switch random {
        case 1,2,3,4:
            let rndRuleNumber = arc4random_uniform(UInt32(rules!.rulesGeneral.values.count))
            let key = Array(rules!.rulesGeneral.keys)[Int(rndRuleNumber)]
            let ruleString = rules!.rulesGeneral[key]
            rules!.rulesGeneral.removeValue(forKey: key)
            return ruleString!
        case 5,6:
            break;
        case 7,8,9:
            break;
        case 10:
            break;
        default:
            print("default")
        }
        
        return "test2"
    }
}
