//
//  GameScreenViewController.swift
//  Getraenkeunfall
//
//  Created by Alexander Karrer on 13.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import UIKit
import Speech

class GameScreenViewController: UIViewController {
    
    var rules: Rules?
    var players: [String]?
    var roleGamesCurrentlyInPlay: Dictionary<String, Int> = [:]
    var roleGamesSolutionInPlay: Dictionary<String, String> = [:]
    let synthAV = AVSpeechSynthesizer()
    
    @IBOutlet weak var ruleLabel: UILabel!
    @IBOutlet var gameView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.nextRule))
        self.gameView.addGestureRecognizer(gesture)
        ruleLabel.text = getNextRule()
        let speechUtterance = GU_Speech.getSpeechUtterance(text: ruleLabel.text!, setting: GU_Speech.SpeechSetting.normal)
        synthAV.speak(speechUtterance)
    }
    
    @objc func nextRule(sender : UITapGestureRecognizer) {
        ruleLabel.text = getNextRule()
        synthAV.pauseSpeaking(at: AVSpeechBoundary.immediate)
        let speechUtterance = GU_Speech.getSpeechUtterance(text: ruleLabel.text!, setting: GU_Speech.SpeechSetting.normal)
        synthAV.speak(speechUtterance)
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
        let random = arc4random_uniform(8) + 1;
        switch random {
        case 1,2,3,4:
            let rndRuleNumber = arc4random_uniform(UInt32(rules!.rulesGeneral.values.count))
            let key = Array(rules!.rulesGeneral.keys)[Int(rndRuleNumber)]
            let ruleString = rules!.rulesGeneral[key]
            rules!.rulesGeneral.removeValue(forKey: key)
            return getPlayableRule(rule: ruleString!)
        case 5,6,7:
            let rndPlayerRule = arc4random_uniform(6) + 1;
            switch rndPlayerRule {
            case 1,2:
                return getOnePlayerRule()
            case 3,4,5:
                if (players?.count)! >= 3 {
                    return getTwoPlayerRule()
                } else {
                    return getOnePlayerRule()
                }
                
            case 6:
                if (players?.count)! >= 4 {
                    return getThreePlayerRule()
                } else if (players?.count)! >= 3 {
                    return getTwoPlayerRule()
                } else {
                    return getOnePlayerRule()
                }
            default:
                break;
            }
        case 8:
            let rndPlayerRule = arc4random_uniform(4) + 1;
            switch rndPlayerRule {
            case 1,2:
                return getOnePlayerRuleGame()
            case 3:
                if (players?.count)! >= 3 {
                    return getTwoPlayerRuleGame()
                } else {
                    return getOnePlayerRuleGame()
                }
            case 4:
                if (players?.count)! >= 4 {
                    return getThreePlayerRuleGame()
                } else if (players?.count)! >= 3 {
                    return getTwoPlayerRuleGame()
                } else {
                    return getOnePlayerRuleGame()
                }
            default:
                break;
            }
        default:
            break;
        }
        
        return "test2"
    }
    
    func getPlayableRule(rule:String) -> String {
        let rndPlayer1 = arc4random_uniform(UInt32(players!.count))
        var rndPlayer2: UInt32
        var rndPlayer3: UInt32
        repeat {
            rndPlayer2 = arc4random_uniform(UInt32(players!.count))
        } while (rndPlayer1 == rndPlayer2)
        repeat {
            rndPlayer3 = arc4random_uniform(UInt32(players!.count))
        } while (rndPlayer3 == rndPlayer1 || rndPlayer3 == rndPlayer2)
        
        return rule.replacingOccurrences(of: "{p1}", with: players![Int(rndPlayer1)]).replacingOccurrences(of: "{p2}", with: players![Int(rndPlayer2)]).replacingOccurrences(of: "{p3}", with: players![Int(rndPlayer3)]).replacingOccurrences(of: "{sipString}", with: getSipAmount()).replacingOccurrences(of: "{distrAmount}", with: getDistrAmount())
    }
    
    func getSipAmount() -> String {
        switch UserDefaults.standard.string(forKey: "difficulty") {
        case "Entspannend":
            let rndsips = arc4random_uniform(7) + 1
            switch rndsips {
            case 1,2:
                return "einen Schluck"
            case 3,4,5,6:
                return "2 Schlücke"
            case 7:
                return "3 Schlücke"
            default:
                break;
            }
        case "Normal":
            let rndsips = arc4random_uniform(12) + 1
            switch rndsips {
            case 1:
                return "einen Schluck"
            case 2,3,4,5,6:
                return "2 Schlücke"
            case 7,8,9,10:
                return "3 Schlücke"
            case 11, 12:
                return "4 Schlücke"
            default:
                break;
            }
        case "Getränkeunfall":
            let rndsips = arc4random_uniform(11) + 1
            switch rndsips {
            case 1,2,3:
                return "3 Schlücke"
            case 4,5,6,7,8:
                return "4 Schlücke"
            case 9,10:
                return "5 Schlücke"
            case 11:
                return "6 Schlücke"
            default:
                break;
            }
        default:
            break;
        }
        return "error"
    }
    
    func getDistrAmount() -> String {
        switch UserDefaults.standard.string(forKey: "difficulty") {
        case "Entspannend":
            let rndsips = arc4random_uniform(3) + 1
            switch rndsips {
            case 1,2:
                return "2 Schlücke"
            case 3:
                return "3 Schlücke"
            default:
                break;
            }
        case "Normal":
            let rndsips = arc4random_uniform(9) + 1
            switch rndsips {
            case 1:
                return "2 Schlücke"
            case 2,3,4,5:
                return "3 Schlücke"
            case 6,7,8:
                return "4 Schlücke"
            case 9:
                return "5 Schlücke"
            default:
                break;
            }
        case "Getränkeunfall":
            let rndsips = arc4random_uniform(11) + 1
            switch rndsips {
            case 1:
                return "3 Schlücke"
            case 2,3,4,5:
                return "4 Schlücke"
            case 6,7,8:
                return "5 Schlücke"
            case 9,10:
                return "6 Schlücke"
            case 11:
                return "7 Schlücke"
            default:
                break;
            }
        default:
            break;
        }
        return "error"
    }
    
    func getPlayableRule(rule:String, solution:String) -> (String, String){
        let rndPlayer1 = arc4random_uniform(UInt32(players!.count))
        var rndPlayer2: UInt32
        var rndPlayer3: UInt32
        repeat {
            rndPlayer2 = arc4random_uniform(UInt32(players!.count))
        } while (rndPlayer1 == rndPlayer2)
        repeat {
            rndPlayer3 = arc4random_uniform(UInt32(players!.count))
        } while (rndPlayer3 == rndPlayer1 && rndPlayer3 == rndPlayer2)
        
        return (rule.replacingOccurrences(of: "{p1}", with: players![Int(rndPlayer1)]).replacingOccurrences(of: "{p2}", with: players![Int(rndPlayer2)]).replacingOccurrences(of: "{p3}", with: players![Int(rndPlayer3)]), solution.replacingOccurrences(of: "{p1}", with: players![Int(rndPlayer1)]).replacingOccurrences(of: "{p2}", with: players![Int(rndPlayer2)]).replacingOccurrences(of: "{p3}", with: players![Int(rndPlayer3)]))
    }
    
    func getOnePlayerRuleGame() -> String {
        let rndRuleNumber = arc4random_uniform(UInt32(rules!.twoPlayerRuleGameRule.values.count))
        let key = Array(rules!.onePlayerRuleGameRule.keys)[Int(rndRuleNumber)]
        roleGamesCurrentlyInPlay[key] = Int(arc4random_uniform(7)) + 4;
        let ruleString = rules!.onePlayerRuleGameRule[key]
        let ruleSet = getPlayableRule(rule: ruleString!, solution: rules!.onePlayerRuleGameResolve[key]!)
        roleGamesSolutionInPlay[key] = ruleSet.1
        rules!.onePlayerRuleGameRule.removeValue(forKey: key)
        rules!.onePlayerRuleGameResolve.removeValue(forKey: key)
        return ruleSet.0
    }
    
    func getTwoPlayerRuleGame() -> String {
        let rndRuleNumber = arc4random_uniform(UInt32(rules!.twoPlayerRuleGameRule.values.count))
        let key = Array(rules!.twoPlayerRuleGameRule.keys)[Int(rndRuleNumber)]
        roleGamesCurrentlyInPlay[key] = Int(arc4random_uniform(7)) + 4;
        let ruleString = rules!.twoPlayerRuleGameRule[key]
        let ruleSet = getPlayableRule(rule: ruleString!, solution: rules!.twoPlayerRuleGameResolve[key]!)
        roleGamesSolutionInPlay[key] = ruleSet.1
        rules!.twoPlayerRuleGameRule.removeValue(forKey: key)
        rules!.twoPlayerRuleGameResolve.removeValue(forKey: key)
        return ruleSet.0
    }
    
    func getThreePlayerRuleGame() -> String {
        let rndRuleNumber = arc4random_uniform(UInt32(rules!.threePlayerRuleGameRule.values.count))
        let key = Array(rules!.threePlayerRuleGameRule.keys)[Int(rndRuleNumber)]
        roleGamesCurrentlyInPlay[key] = Int(arc4random_uniform(7)) + 4;
        roleGamesSolutionInPlay[key] = rules!.threePlayerRuleGameResolve[key]
        let ruleString = rules!.threePlayerRuleGameRule[key]
        let ruleSet = getPlayableRule(rule: ruleString!, solution: rules!.threePlayerRuleGameResolve[key]!)
        roleGamesSolutionInPlay[key] = ruleSet.1
        rules!.threePlayerRuleGameRule.removeValue(forKey: key)
        rules!.threePlayerRuleGameResolve.removeValue(forKey: key)
        return ruleSet.0
    }
    
    func getOnePlayerRule() -> String {
        let rndRuleNumber = arc4random_uniform(UInt32(rules!.onePlayerGame.values.count))
        let key = Array(rules!.onePlayerGame.keys)[Int(rndRuleNumber)]
        let ruleString = rules!.onePlayerGame[key]
        rules!.onePlayerGame.removeValue(forKey: key)
        return getPlayableRule(rule: ruleString!)
    }
    
    func getTwoPlayerRule() -> String {
        let rndRuleNumber = arc4random_uniform(UInt32(rules!.twoPlayerGame.values.count))
        let key = Array(rules!.twoPlayerGame.keys)[Int(rndRuleNumber)]
        let ruleString = rules!.twoPlayerGame[key]
        rules!.twoPlayerGame.removeValue(forKey: key)
        return getPlayableRule(rule: ruleString!)
    }
    
    func getThreePlayerRule() -> String {
        let rndRuleNumber = arc4random_uniform(UInt32(rules!.threePlayerGame.values.count))
        let key = Array(rules!.threePlayerGame.keys)[Int(rndRuleNumber)]
        let ruleString = rules!.threePlayerGame[key]
        rules!.threePlayerGame.removeValue(forKey: key)
        return getPlayableRule(rule: ruleString!)
    }
}
