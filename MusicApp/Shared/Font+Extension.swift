//
//  Font+Extension.swift
//  MusicApp
//
//  Created by Gilles Sagot on 23/09/2022.
//

import Foundation
import SwiftUI


extension Font {
    static let boldFont = Font.custom("MabryDeezer-Black", size: Font.TextStyle.largeTitle.size, relativeTo: .caption)
    static let mediumFont = Font.custom("MabryDeezer-Black", size: Font.TextStyle.title2.size, relativeTo: .caption)
    static let regularFont = Font.custom("MabryDeezer-Black", size: Font.TextStyle.headline.size, relativeTo: .caption)
    static let lightFont = Font.custom("MabryDeezer-Black", size: Font.TextStyle.footnote.size, relativeTo: .caption)
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 60
        case .title: return 48
        case .title2: return 34
        case .title3: return 24
        case .headline, .body: return 18
        case .subheadline, .callout: return 16
        case .footnote: return 14
        case .caption: return 12
        case .caption2: return 10
        @unknown default:
            return 8
        }
    }
}
