//
//  PlayModeViewController.swift
//  Getraenkeunfall
//
//  Created by Peter Jedinger on 18.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//
import UIKit

class PlayModeViewController: UIViewController {
    
    var playerNames:[String] = ["", "", ""]
    var rules: Rules?
    let defaults =  UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameScreenViewController {
            let dest = segue.destination as? GameScreenViewController
            dest?.rules = rules
            dest?.players = playerNames
            let sendertag = (sender as! UIButton).tag
            switch sendertag {
                case 1:
                    defaults.set("Entspannend", forKey: "difficulty")
                    break;
                case 2:
                    defaults.set("Normal", forKey: "difficulty")
                    break;
                case 3:
                    defaults.set("Getränkeunfall", forKey: "difficulty")
                    break;
                default:
                    defaults.set("Normal", forKey: "difficulty")
            }
        }
    }
}
