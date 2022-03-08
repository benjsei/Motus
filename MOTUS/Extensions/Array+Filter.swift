//
//  Array+Filter.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

extension Array where Element == String {
    func avecCorrespondance(_ motTente: String, _ correspondance: String) -> [String] {
        var source = self

        source
            .removeAll { mot in
                !mot.estCorrespondant(motTente, correspondance)
            }

        return source
    }
}
