//
//  String+Extension.swift
//  MusicApp
//
//  Created by Gilles Sagot on 24/09/2022.
//

import Foundation

extension String {
    func trimmedAndEscaped ()-> String {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        return trimmedString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? self
    }
    
    func removeParentheses ()-> String {
        guard let upperIndex = (self.range(of: "(")?.lowerBound) else { return self }
           let firstPart: String = .init(self.prefix(upTo: upperIndex))
           return firstPart
    }
    
}
