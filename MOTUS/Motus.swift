//
//  Motus.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

class Motus {
    private var dictionnaire: [String] = []

    func charger(_ fichier: String) {
        do {
            let contenu = try String(contentsOfFile: fichier)
            dictionnaire = contenu
                .components(separatedBy: Constantes.Chaines.retourChariot)
                .map { $0.uppercased() }
                .filter { $0 != Constantes.Chaines.vide }
        } catch {}
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
            return Constantes.Chaines.aucuneProposition
        }

        let toutesLesCorrespondances = recupererToutesCorrespondances()
        let propositions = recupererPropositions(toutesLesCorrespondances)
        return propositions.max(by: { $0.entropie < $1.entropie })?.mot ?? Constantes.Chaines.vide
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
        var nouveau: [String] = [Constantes.Chaines.vide]

        for _ in 1 ... Constantes.Parametres.nombreLettre {
            nouveau = ajouterNiveau(nouveau)
        }

        return nouveau
    }

    private func ajouterNiveau(_ correspondances: [String]) -> [String] {
        var nouveau: [String] = []
        correspondances
            .forEach { correspondance in
                Constantes
                    .criteres
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
