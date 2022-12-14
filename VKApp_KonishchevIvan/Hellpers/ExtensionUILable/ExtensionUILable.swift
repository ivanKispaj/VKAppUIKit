//
//  ExtensionUILable.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.07.2022.
//

import UIKit

extension UILabel {
    
    public func resizeIfNeeded() -> CGFloat? {
        guard let text = text, !text.isEmpty else { return nil }
        if isTruncated() {
            numberOfLines = 0
            sizeToFit()
            return frame.height
        }
        return nil
    }
    
    func isTruncated() -> Bool {
        guard let text = text, !text.isEmpty else { return false }
        
        let size: CGSize = text.size(withAttributes: [NSAttributedString.Key.font: font as Any])
        return size.width > self.bounds.size.width
    }
}

