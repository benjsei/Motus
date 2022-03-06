//
//  StepDefiner+Helper.swift
//  MOTUS
//
//  Created by Benjamin SEILLIER on 06/03/2022.
//

import XCTest_Gherkin

extension StepDefiner {
    func step<T: MatchedStringRepresentable>(exactly exact: String,
                                             file _: String = #file,
                                             line _: Int = #line,
                                             completion: @escaping (T) -> Void) {
        let regexp = "^\(exact)$"
        step(regexp, f: completion)
    }

    func step<T: Collection & MatchedStringRepresentable>(exactly exact: String,
                                                          file _: String = #file,
                                                          line _: Int = #line,
                                                          completion: @escaping (T) -> Void) {
        let regexp = "^\(exact)$"
        step(regexp, f: completion)
    }

    func step<T: MatchedStringRepresentable, U: MatchedStringRepresentable>(exactly exact: String,
                                                                            file _: String = #file,
                                                                            line _: Int = #line,
                                                                            completion: @escaping (T, U) -> Void) {
        let regexp = "^\(exact)$"
        step(regexp, f: completion)
    }
}
