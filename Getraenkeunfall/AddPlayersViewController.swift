//
//  AddPlayersViewController.swift
//  Getraenkeunfall
//
//  Created by Alexander Karrer on 10.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import UIKit
import Speech

class PlayerCell : UITableViewCell{
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var speakerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class AddPlayerCell : UITableViewCell{
    @IBOutlet weak var addPlayerButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class AddPlayersViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var playerNames:[String] = ["", "", ""]
    var rules: Rules?
    let synthAV = AVSpeechSynthesizer()

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerTableView.delegate = self
        self.playerTableView.dataSource = self
        
        //Makes the keyboard go away where tapped anywhere in the view.
      self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerNames.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row != playerNames.count{
            let cell = playerTableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
            let playerName = playerNames[indexPath.row]
            cell.playerNameTextField.text = playerName
            cell.playerNameTextField.placeholder = "Spieler \(indexPath.row + 1)"
            //cell.speakerButton
            return cell
        }else{
            let cell = playerTableView.dequeueReusableCell(withIdentifier: "AddPlayerCell", for: indexPath) as! AddPlayerCell
            return cell
        }
    }
    


//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        playerNames.remove(at: indexPath.row)
//        playerTableView.deleteRows(at: [indexPath], with: .automatic)
//    }
    
    //Closes the keyboard when the done button is clicked.
    
    @IBAction func addButtonClicked(_ sender: Any) {
            setDataSourceFromCells()
            playerNames.append("")
            playerTableView.reloadData()
            playerTableView.scrollToRow(at: IndexPath(item: playerNames.count, section: 0), at: UITableViewScrollPosition.bottom, animated: true)
    }
    
    @IBAction func playAudioForName(sender: UIButton){
        if let superview = sender.superview{
            for subview in superview.subviews
            {
                if let textField = subview as? UITextField
                {
                    let speechUtterance = GU_Speech.getSpeechUtterance(text: textField.text!, setting: GU_Speech.SpeechSetting.normal)
                    synthAV.speak(speechUtterance)
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setDataSourceFromCells(){
        for (index, cell) in playerTableView.visibleCells.enumerated() {
            if let playerCell = cell as? PlayerCell {
                playerNames[index] = playerCell.playerNameTextField.text!
            }
        }
    }
    
    func prepPlayerNames(){
        setDataSourceFromCells()
        for (index, name) in playerNames.enumerated(){
                playerNames[index] = name.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        playerNames = playerNames.filter { $0 != "" }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameScreenViewController {
            let dest = segue.destination as? GameScreenViewController
            dest?.rules = rules
            prepPlayerNames()
            dest?.players = playerNames
        }
    }
    
}

