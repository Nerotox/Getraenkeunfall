//
//  StringLinesExtension.swift
//  Gertränkeunfall
//
//  Created by Alexander Karrer on 21.04.18.
//  Copyright © 2018 Alexander Karrer. All rights reserved.
//

import Foundation

extension String {
    var lines: [String] {
        var result: [String] = []
        enumerateLines { line, _ in result.append(line) }
        return result
    }
}
