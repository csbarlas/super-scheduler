//
//  Constants.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/16/24.
//

import Foundation
import SpriteKit

enum CommonData {
    static let gameWindowSize: CGSize = CGSize(width: 1024, height: 768)
    static let gameWindowCenter: CGPoint = CGPoint(x: gameWindowSize.width / 2, y: gameWindowSize.height / 2)
    static let checkmarkSpriteSize = CGSize(width: 110, height: 110)
    static let foodSpriteSize = CGSize(width: 90, height: 90)
    
    static let waitForDialog = SKAction.wait(forDuration: 4.5)
    static let foodFadeIn = SKAction.fadeIn(withDuration: 3.0)
    static let standardFadeIn = SKAction.fadeIn(withDuration: 1.0)
    static let standardFadeOut = SKAction.fadeOut(withDuration: 1.0)
    static let standardWait = SKAction.wait(forDuration: 1.0)
    static let waitForFoodFade = SKAction.wait(forDuration: 3.0)
    static let checkmarkFade = SKAction.fadeIn(withDuration: 0.5)
}
