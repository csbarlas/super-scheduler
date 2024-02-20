//
//  BurgerSprite.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/19/24.
//

import Foundation
import SpriteKit

struct FoodSprite {
    private let scene: GameScene
    private let colorSprite, graySprite, checkmarkSprite: SKSpriteNode
    
    init(scene: GameScene, position: CGPoint, imageNamed: String) {
        self.scene = scene
        
        colorSprite = SKSpriteNode(imageNamed: imageNamed)
        graySprite = SKSpriteNode(imageNamed: imageNamed + "-gray")
        
        for sprite in [colorSprite, graySprite] {
            sprite.texture?.filteringMode = .nearest
            sprite.scale(to: Constants.foodSpriteSize)
            sprite.position = position
            sprite.alpha = 0
        }
        
        checkmarkSprite = SKSpriteNode(imageNamed: "checkmark")
        checkmarkSprite.texture?.filteringMode = .nearest
        checkmarkSprite.scale(to: Constants.checkmarkSpriteSize)
        checkmarkSprite.position = position
        checkmarkSprite.alpha = 0
        
        scene.addChild(graySprite)
        scene.addChild(colorSprite)
        scene.addChild(checkmarkSprite)
    }
    
    func runActionOnGraySprite(_ action: SKAction) {
        graySprite.run(action)
    }
    
    func runActionOnColorSprite(_ action: SKAction) {
        colorSprite.run(action)
    }
    
    func runActionOnCheckmarkSprite(_ action: SKAction) {
        checkmarkSprite.run(action)
    }
    
    func runActionOnAllSprites(_ action: SKAction) {
        for sprite in [graySprite, colorSprite, checkmarkSprite] {
            sprite.run(action)
        }
    }
    
    func startCompletionAnimation(_ delay: [SKAction]) {
        let foodFadeIn = SKAction.sequence(delay + [Constants.foodFadeIn])
        colorSprite.run(foodFadeIn)
        
        let checkFadeIn = SKAction.sequence(delay + [Constants.waitForFoodFade, Constants.checkmarkFade])
        checkmarkSprite.run(checkFadeIn)
    }
}
