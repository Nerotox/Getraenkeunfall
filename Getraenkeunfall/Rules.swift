//
//  Rules.swift
//  Getraenkeunfall
//
//  Created by Alexander Karrer on 10.06.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import Foundation

struct Rules {
    var rulesGeneral: Dictionary<String, String>
    var onePlayerGame: Dictionary<String, String>
    var twoPlayerGame: Dictionary<String, String>
    var threePlayerGame: Dictionary<String, String>
    var onePlayerRuleGameRule: Dictionary<String, String>
    var onePlayerRuleGameResolve: Dictionary<String, String>
    var twoPlayerRuleGameRule: Dictionary<String, String>
    var twoPlayerRuleGameResolve: Dictionary<String, String>
    var threePlayerRuleGameRule: Dictionary<String, String>
    var threePlayerRuleGameResolve: Dictionary<String, String>
    
    init() {
        rulesGeneral = [:]
        onePlayerGame = [:]
        twoPlayerGame = [:]
        threePlayerGame = [:]
        onePlayerRuleGameRule = [:]
        onePlayerRuleGameResolve = [:]
        twoPlayerRuleGameRule = [:]
        twoPlayerRuleGameResolve = [:]
        threePlayerRuleGameRule = [:]
        threePlayerRuleGameResolve = [:]
    }
}
