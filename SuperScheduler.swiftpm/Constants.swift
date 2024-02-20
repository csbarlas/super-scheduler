//
//  Constants.swift
//  AppPlaygroundTest1
//
//  Created by Christopher Barlas on 2/16/24.
//

import Foundation
import SpriteKit

enum Constants {
    static let gameWindowSize: CGSize = CGSize(width: 1024, height: 768)
    static let personSpriteHeight: Int = 256
    static let personSpriteWidth: Int = 128
    static let firstCustomerPos: CGPoint = CGPoint(x: 128, y: 240)
    static let secondCustomerPos: CGPoint = CGPoint(x: 384, y: 240)
    static let thirdCustomerPos: CGPoint = CGPoint(x: 640, y: 240)
    static let fourthCustomerPos: CGPoint = CGPoint(x: 896, y: 240)
    static let thoughtBubbleOffset: CGFloat = 288
    static let checkmarkSpriteSize = CGSize(width: 110, height: 110)
    static let foodSpriteSize = CGSize(width: 90, height: 90)
    
    static let waitForDialog = SKAction.wait(forDuration: 4.5)
    static let foodFadeIn = SKAction.fadeIn(withDuration: 3.0)
    static let standardFadeIn = SKAction.fadeIn(withDuration: 1)
    static let standardWait = SKAction.wait(forDuration: 1)
    static let waitForFoodFade = SKAction.wait(forDuration: 3.0)
    static let checkmarkFade = SKAction.fadeIn(withDuration: 0.5)
}
