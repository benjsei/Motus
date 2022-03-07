//
//  String+EstCorrespondant.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

extension String {
    func estCorrespondant(_ motTenteOrigine: String, _ correspondances: String) -> Bool {
        var motEnTraitement = uppercased()
        let motTente = motTenteOrigine.uppercased()

        for (index, char) in correspondances.enumerated() {
            let critere = Constantes.Critere.from(char: char)

            switch critere {
            case .correct:
                if motEnTraitement[index] != motTente[index] {
                    return false
                }
                motEnTraitement.setCharAt(index, Constantes.Chaines.estTraite)
            case .incorrect:
                if motEnTraitement.contains(motTente[index]) {
                    return false
                }
            case .partiel:
                if motEnTraitement[index] == motTente[index] {
                    return false
                }
                if let distance = motEnTraitement.distance(of: motTente[index]) {
                    motEnTraitement.setCharAt(distance, Constantes.Chaines.estTraite)
                } else {
                    return false
                }
            }
        }

        return true
    }
}
