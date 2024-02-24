//
//  CustomerSprite.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/16/24.
//

import Foundation
import SpriteKit

struct CustomerSprite {
    let scene: GameScene
    let personSprite, thoughtBubbleSprite: SKSpriteNode
    private static let personSpriteSize = CGSize(width: 128, height: 256)
    private static let thoughtBubbleSpriteSize = CGSize(width: 256, height: 256)
    private static let thoughtBubbleOffset: CGFloat = 288
    
    init(scene: GameScene, customerTexture: String, pos: CGPoint) {
        self.scene = scene
        
        personSprite = SKSpriteNode(imageNamed: customerTexture)
        personSprite.texture?.filteringMode = .nearest
        personSprite.scale(to: CustomerSprite.personSpriteSize)
        personSprite.position = pos
        personSprite.alpha = 0
        scene.addChild(personSprite)
        
        thoughtBubbleSprite = SKSpriteNode(imageNamed: "thought-bubble")
        thoughtBubbleSprite.texture?.filteringMode = .nearest
        thoughtBubbleSprite.scale(to: CustomerSprite.thoughtBubbleSpriteSize)
        thoughtBubbleSprite.position = CGPoint(x: pos.x, y: pos.y + CustomerSprite.thoughtBubbleOffset)
        thoughtBubbleSprite.alpha = 0
        scene.addChild(thoughtBubbleSprite)
    }
    
    func startEntranceAnimation(_ delay: [SKAction]) {
        let actions = SKAction.sequence(delay + [CommonData.standardFadeIn])
        personSprite.run(actions)
        thoughtBubbleSprite.run(actions)
    }
}
