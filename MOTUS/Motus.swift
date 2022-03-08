//
//  Motus.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import Darwin

class Motus {
    private var dictionnaire: [String] = []
    private var dictionnaireRestant: [String] = []
    private var toutesCorrespondances: [String] = []

    init() {
        toutesCorrespondances = recupererToutesCorrespondances()
    }

    func charger(_ fichier: String) {
        do {
            let contenu = try String(contentsOfFile: fichier)
            dictionnaire = contenu
                .components(separatedBy: Constantes.Chaines.retourChariot)
                .map { $0.uppercased() }
                .filter { $0 != Constantes.Chaines.vide }

            dictionnaireRestant = dictionnaire
        } catch {}
    }

    func ajouterReponse(_ mot: String, _ correspondance: String) {
        dictionnaireRestant = dictionnaireRestant.avecCorrespondance(mot, correspondance)
    }

    func nombreCorrespondance(_ motTente: String, _ correspondance: String) -> Int {
        let motsCandidats = dictionnaireRestant.avecCorrespondance(motTente, correspondance)
        return motsCandidats.count
    }

    func proposer() -> String {
        guard dictionnaireRestant.count > Constantes.Parametres.nombreMinumumReponse else {
            return dictionnaireRestant.first ?? Constantes.Chaines.aucuneProposition
        }
        let candidats = getCandidats()
        let propositions = recupererPropositions(candidats)
        return propositions.max(by: { $0.entropie < $1.entropie })?.mot ?? Constantes.Chaines.vide
    }

    private func getCandidats() -> [String] {
        if dictionnaireRestant.count < Constantes.Parametres.nombreMinumumRestants {
            return dictionnaireRestant
        }
        return dictionnaire
    }

    private func recupererPropositions(_ candidats: [String]) -> [Proposition] {
        var propositions = [Proposition]()
        candidats
            .forEach { candidat in
                let proposition = evaluerProposition(candidat)
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

    private func calculerSommeInformation(_ mot: String) -> Float {
        var sommeInformation = Float(0.00)

        toutesCorrespondances
            .forEach { correspondance in
                let reduction = Float(nombreCorrespondance(mot, correspondance)) / Float(dictionnaireRestant.count)
                if reduction.estPositifNonNul {
                    let information = -1 * reduction * log2(reduction)
                    sommeInformation += information
                }
            }

        return sommeInformation
    }

    private func evaluerProposition(_ mot: String) -> Proposition {
        let sommeInformation = calculerSommeInformation(mot)
        let entropie = sommeInformation / Float(toutesCorrespondances.count)
        return Proposition(mot: mot.uppercased(), entropie: entropie)
    }
}
