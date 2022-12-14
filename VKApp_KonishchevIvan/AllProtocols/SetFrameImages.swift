//
//  File.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 10.04.2022.
//

import UIKit

protocol SetFrameImages: AnyObject {
    var frameImages: [CGRect]? {get set}
    var currentFrameImages: CGRect? {get set}
    var collectionFrame: CGRect? {get set}
    func setFrameImages(_ frame: [CGRect], currentFrame: CGRect)
    func setCurrentImage(_ currentImage: Int)
}

