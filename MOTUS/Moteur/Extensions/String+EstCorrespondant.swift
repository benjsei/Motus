//
//  String+EstCorrespondant.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

extension String {
    func estCorrespondant(_ motTente: String, _ correspondances: String) -> Bool {
        var motEnTraitement = self

        for (index, char) in correspondances.enumerated() {
            let critere = Critere.from(char: char)

            switch critere {
            case .correct:
                if motEnTraitement[index].uppercased() != motTente[index].uppercased() {
                    return false
                }
                motEnTraitement.setCharAt(index, Chaines.espace)
            case .incorrect:
                if motEnTraitement.uppercased().firstIndex(of: motTente.uppercased()[index]) != nil {
                    return false
                }
            case .partiel:
                if motEnTraitement[index].uppercased() == motTente[index].uppercased() {
                    return false
                }
                if let distance = motEnTraitement.uppercased().distance(of: motTente.uppercased()[index]) {
                    motEnTraitement.setCharAt(distance, Chaines.espace)
                } else {
                    return false
                }
            }
        }

        return true
    }
}
