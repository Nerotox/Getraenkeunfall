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
            print(lin)
        }
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
