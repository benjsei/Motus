//
//  Constantes.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

enum Constantes {
    enum Parametres {
        static let nombreLettre = 5
        static let nombreMinumumReponse = 1
        static let nombreMinumumRestants = 4
    }

    enum Chaines {
        static let vide = ""
        static let estTraite = " "
        static let retourChariot = "\n"
        static let aucuneProposition = "AUCUNE PROPOSITION"
    }

    enum Critere: String {
        case incorrect = "0"
        case partiel = "1"
        case correct = "2"

        static func from(char: Character) -> Critere {
            Critere(rawValue: String(char)) ?? incorrect
        }
    }

    static let criteres = [Critere.incorrect, Critere.partiel, Critere.correct]
}
