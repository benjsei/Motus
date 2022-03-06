//
//  Critere.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

enum Critere: String {
    case incorrect = "0"
    case partiel = "1"
    case correct = "2"

    static func from(char: Character) -> Critere {
        Critere(rawValue: String(char)) ?? incorrect
    }
}
