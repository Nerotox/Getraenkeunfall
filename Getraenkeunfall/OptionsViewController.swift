//
//  OptionsViewController.swift
//  Gertränkeunfall
//
//  Created by Alexander Karrer on 20.04.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    //UI Elements
    @IBOutlet weak var sliderSiri: UISwitch!
    @IBOutlet weak var pickerDifficulty: UIPickerView!
    
    //Difficulty Array
    var difficulties = ["Entspannend", "Normal", "Getränkeunfall"]
    
    //defaults for storing the selected Difficulty and the Siri Settings.
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set the first object if this is the first time calling the options.
        if defaults.string(forKey: "difficulty") == nil {
            defaults.set(difficulties[0], forKey: "difficulty")
        }
        
        //set the data sources for the Difficulty picker
        self.pickerDifficulty.delegate = self
        self.pickerDifficulty.dataSource = self
        
        //set the picker to the currently used difficulty
        switch defaults.string(forKey: "difficulty") {
        case "Entspannend":
            pickerDifficulty.selectRow(0, inComponent: 0, animated: false)
        case "Normal":
            pickerDifficulty.selectRow(1, inComponent: 0, animated: false)
        case "Getränkeunfall":
            pickerDifficulty.selectRow(2, inComponent: 0, animated: false)
        default:
            pickerDifficulty.selectRow(0, inComponent: 0, animated: false)
        }
        
        //set the Siri Slider State
        sliderSiri.setOn(defaults.bool(forKey: "sirienabled"), animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return difficulties.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaults.set(difficulties[row], forKey: "difficulty")
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return difficulties[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is HomeViewController {
            //set the siri state to the slider state
            defaults.set(sliderSiri.isOn, forKey: "sirienabled")
        }
    }

}
