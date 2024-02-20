//
//  CustomerSprite.swift
//  AppPlaygroundTest1
//
//  Created by Christopher Barlas on 2/16/24.
//

import Foundation
import SpriteKit

struct CustomerSprite {
    let scene: GameScene
    
    let personSprite, thoughtBubbleSprite: SKSpriteNode
    
    
    init(scene: GameScene, customerTexture: String, pos: CGPoint) {
        self.scene = scene
        
        personSprite = SKSpriteNode(imageNamed: customerTexture)
        personSprite.texture?.filteringMode = .nearest
        personSprite.scale(to: CGSize(width: Constants.personSpriteWidth, height: Constants.personSpriteHeight))
        personSprite.position = pos
        personSprite.alpha = 0
        scene.addChild(personSprite)
        
        thoughtBubbleSprite = SKSpriteNode(imageNamed: "thought_bubble")
        thoughtBubbleSprite.texture?.filteringMode = .nearest
        thoughtBubbleSprite.scale(to: CGSize(width: 256, height: 256))
        thoughtBubbleSprite.position = CGPoint(x: pos.x, y: pos.y + Constants.thoughtBubbleOffset)
        thoughtBubbleSprite.alpha = 0
        scene.addChild(thoughtBubbleSprite)
    }
    
    func startEntranceAnimation(_ delay: [SKAction]) {
        let actions = SKAction.sequence(delay + [Constants.standardFadeIn])
        personSprite.run(actions)
        thoughtBubbleSprite.run(actions)
    }
}
