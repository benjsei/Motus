//
//  Collection+Rechercher.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

extension Collection {
    func distance(to index: Index) -> Int {
        distance(from: startIndex, to: index)
    }
}
