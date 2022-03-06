//
//  Motus.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

class Motus {
    private let nombreLettre = 5
    private let criteres: [Critere]
    private var dictionnaire: [String] = []

    init() {
        criteres = [Critere.incorrect, Critere.partiel, Critere.correct]
    }

    func charger(_ fichier: String) {
        do {
            let contenu = try String(contentsOfFile: fichier)
            dictionnaire = contenu
                .components(separatedBy: Chaines.retourChariot)
                .map { $0.uppercased() }
                .filter { $0 != Chaines.vide }
        } catch {
            print("Fatal Error: \(error.localizedDescription)")
        }
    }

    func ajouterReponse(_ reponse: String, _ resultat: String) {
        dictionnaire = dictionnaire.avecCorrespondances(reponse, resultat)
    }

    func nombreCorrespondance(_ motTente: String, _ correspondances: String) -> Int {
        let motsCandidats = dictionnaire.avecCorrespondances(motTente, correspondances)
        return motsCandidats.count
    }

    func proposer() -> String {
        guard !dictionnaire.isEmpty else {
            return Chaines.vide
        }

        let toutesLesCorrespondances = recupererToutesCorrespondances()
        let propositions = recupererPropositions(toutesLesCorrespondances)
        return propositions.max(by: { $0.entropie < $1.entropie })?.mot ?? Chaines.vide
    }

    private func recupererPropositions(_ toutesLesCorrespondances: [String]) -> [Proposition] {
        var propositions = [Proposition]()
        dictionnaire
            .forEach { mot in
                let proposition = evaluerProposition(mot, toutesLesCorrespondances, dictionnaire.count)
                propositions.append(proposition)
            }

        return propositions
    }

    private func recupererToutesCorrespondances() -> [String] {
        var nouveau: [String] = [Chaines.vide]

        for _ in 1 ... nombreLettre {
            nouveau = ajouterNiveau(nouveau)
        }

        return nouveau
    }

    private func ajouterNiveau(_ correspondances: [String]) -> [String] {
        var nouveau: [String] = []
        correspondances
            .forEach { correspondance in
                criteres
                    .forEach { critere in
                        nouveau.append(correspondance + critere.rawValue)
                    }
            }
        return nouveau
    }

    private func calculerSommeInformation(_ mot: String, _ correspondances: [String], _: Int) -> Float {
        var sommeInformation: Float = 0.00

        correspondances
            .forEach { correspondance in
                let reduction = Float(nombreCorrespondance(mot, correspondance)) / Float(dictionnaire.count)
                if reduction > 0 {
                    let information = -1 * reduction * log2(reduction)
                    sommeInformation += information
                }
            }

        return sommeInformation
    }

    private func evaluerProposition(_ mot: String, _ correspondances: [String], _: Int) -> Proposition {
        let sommeInformation = calculerSommeInformation(mot, correspondances, dictionnaire.count)
        let entropie = sommeInformation / Float(correspondances.count)
        return Proposition(mot: mot.uppercased(), entropie: entropie)
    }
}
