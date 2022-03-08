//
//  StringProtocol+Rechercher.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }

    func distance(of element: Element) -> Int? {
        firstIndex(of: element)?.distance(in: self)
    }
}
