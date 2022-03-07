//
//  String.Index+Rechercher.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

extension String.Index {
    func distance<S: StringProtocol>(in string: S) -> Int {
        string.distance(to: self)
    }
}
