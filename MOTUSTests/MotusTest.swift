//
//  MotusTest.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

@testable import MOTUS
import SwiftUI
import XCTest
import XCTest_Gherkin

class MotusTest: XCTestCase {
    func test_motus_calculerCorrespondanceMot() {
        NativeRunner.runScenario(featureFile: "MotusTest.feature",
                                 scenario: "Calculer la correspondance d'un mot",
                                 testCase: self,
                                 mapStepDefiner: MotusStepsDefinition.self)
    }

    func test_motus_calculerNombreMotsCorrespondants() {
        NativeRunner.runScenario(featureFile: "MotusTest.feature",
                                 scenario: "Calculer le nombre de mots correspondants",
                                 testCase: self,
                                 mapStepDefiner: MotusStepsDefinition.self)
    }

    func test_motus_proposerLeMotOptimal() {
        NativeRunner.runScenario(featureFile: "MotusTest.feature",
                                 scenario: "Proposer le mot optimal sur 100 mots",
                                 testCase: self,
                                 mapStepDefiner: MotusStepsDefinition.self)
    }

    func test_motus_proposerLeMotOptimalListeVide() {
        NativeRunner.runScenario(featureFile: "MotusTest.feature",
                                 scenario: "Ne pas proposer le mot optimal si la liste de mots est vide",
                                 testCase: self,
                                 mapStepDefiner: MotusStepsDefinition.self)
    }

//    func test_motus_proposerLeMotOptimalPourDuVrai() {
//        NativeRunner.runScenario(featureFile: "MotusTest.feature",
//                                 scenario: "Proposer le mot optimal sur le Lexique de WORDLE FR",
//                                 testCase: self,
//                                 mapStepDefiner: MotusStepsDefinition.self)
//    }

    func test_motus_proposerLeMotOptimalPourDuVraiaprerspremierereponse_FR() {
        NativeRunner.runScenario(featureFile: "MotusTest.feature",
                                 scenario: "Proposer le mot optimal sur le Lexique de WORDLE FR après plusieurs tentatives",
                                 testCase: self,
                                 mapStepDefiner: MotusStepsDefinition.self)
    }

    func test_motus_proposerLeMotOptimalPourDuVraiaprerspremierereponse_EN() {
        NativeRunner.runScenario(featureFile: "MotusTest.feature",
                                 scenario: "Proposer le mot optimal sur le Lexique de WORDLE EN après plusieurs tentatives",
                                 testCase: self,
                                 mapStepDefiner: MotusStepsDefinition.self)
    }
}

private final class MotusStepsDefinition: StepDefiner {
    var motsDepart: [String] = []
    var motInitial = Constantes.Chaines.vide
    var motTente = Constantes.Chaines.vide
    var evaluation = Constantes.Chaines.vide
    var motus = Motus()
    var correspondances = Constantes.Chaines.vide
    var proposition = Constantes.Chaines.vide

    private func setUp() {
        motus = Motus()
    }

    override func defineSteps() {
        step(exactly: "Le dictionnaire \"(.+)\" est chargé") { (fichier: String) in
            let bundle = Bundle(for: MotusTest.self)
            let url = bundle.path(forResource: "lexiques/\(fichier)", ofType: "txt")
            self.motus.charger(url!)
        }

        step(exactly: "Le mot initial est \"(.+)\"") { (motInitial: String) in
            self.motInitial = motInitial
        }

        step(exactly: "Le mot tenté est \"(.+)\"") { (motTente: String) in
            self.motTente = motTente
        }

        step(exactly: "Le mot candidat est \"(.+)\"") { (candidat: String) in
            self.motInitial = candidat
        }

        step(exactly: "La reponse est \"(.+)\"") { (reponse: String) in
            self.motTente = reponse
        }

        step(exactly: "Levaulation est \"(.+)\"") { (evaulation: String) in
            self.evaluation = evaulation
        }

        step(exactly: "La correspondance est \"(.+)\"") { (correspondance: String) in
            let estCorrespondant = self.motInitial.estCorrespondant(self.motTente, self.evaluation)

            XCTAssert((estCorrespondant ? "OUI" : "NON") == correspondance, "\(self.motInitial) : \(self.motTente) : \(self.evaluation)")
        }

        step(exactly: "La reponse essayée est \"(.+)\" avec comme résultat \"(.+)\"") { (reponse: String, resultat: String) in
            self.motus.ajouterReponse(reponse, resultat)
        }

        step(exactly: "La correspondance évalué est \"(.+)\"") { (correspondances: String) in
            self.correspondances = correspondances
        }

        step(exactly: "Je veux avoir le mot avec le plus de correspondance moyenne") {
            self.proposition = self.motus.proposer()
        }

        step(exactly: "Le nombre de mot correspondant est \"(.+)\"") { (nombreCorrespondanceAttendu: String) in
            let nombreCorrespondance = self.motus.nombreCorrespondance(self.motTente, self.correspondances)

            XCTAssert(nombreCorrespondanceAttendu == "\(nombreCorrespondance)", "\(nombreCorrespondance) : \(nombreCorrespondanceAttendu)")
        }

        step(exactly: "Le mot proposé est \"(.+)\"") { (motpropose: String) in
            XCTAssert(self.proposition == motpropose, "\(self.proposition) : \(motpropose)")
        }
    }
}
