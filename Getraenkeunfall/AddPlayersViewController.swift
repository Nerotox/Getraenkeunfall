//
//  AddPlayersViewController.swift
//  Getraenkeunfall
//
//  Created by Alexander Karrer on 10.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import UIKit

class AddPlayersViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var playerNames:[String] = []
    
    var rules: Rules?
    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var playerNamesTableView: UITableView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerNameTextField.delegate = self
        self.playerNamesTableView.delegate = self
        self.playerNamesTableView.dataSource = self
        //Makes the keyboard go away where tapped anywhere in the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerNamesTableView.dequeueReusableCell(withIdentifier: "nameCell")!
        cell.textLabel?.text = playerNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        playerNames.remove(at: indexPath.row)
        playerNamesTableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //Closes the keyboard when the done button is clicked.
    @IBAction func addButtonClicked(_ sender: Any) {
        if let name = playerNameTextField.text {
            playerNames.append(name)
        }
        playerNameTextField.text = ""
        playerNamesTableView.reloadData()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is GameScreenViewController {
            let dest = segue.destination as? GameScreenViewController
            dest?.rules = rules
            dest?.players = playerNames
        }
    }
}
