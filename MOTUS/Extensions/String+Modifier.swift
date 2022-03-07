//
//  String+Modifier.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import SwiftUI

public extension String {
    mutating func setCharAt(_ index: Int, _ new: String) {
        let stringIndex = self.index(startIndex, offsetBy: index)
        replaceSubrange(stringIndex ... stringIndex, with: new)
    }
}
