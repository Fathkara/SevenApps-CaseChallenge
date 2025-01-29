//
//  Font.swift
//  SevenAppsCaseChallenge
//
//  Created by Fatih Kara on 29.01.2025.
//

import UIKit
final class Font {
    enum FontWeight {
        case Light
        case Regular
        case Medium
        case SemiBold
        case Bold
    }
    
    static func custom(size: CGFloat = 14, fontWeight: FontWeight = .Light) -> UIFont {
        return UIFont(name: "Montserrat-\(fontWeight)",
                      size: size * UIScreen.main.bounds.height * 0.00115)!
    }
}
