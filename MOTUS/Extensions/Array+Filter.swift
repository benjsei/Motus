//
//  Array+Filter.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

extension Array where Element == String {
    func avecCorrespondances(_ motTente: String, _ correspondances: String) -> [String] {
        var source = self

        source
            .removeAll { mot in
                !mot.estCorrespondant(motTente, correspondances)
            }

        return source
    }
}
