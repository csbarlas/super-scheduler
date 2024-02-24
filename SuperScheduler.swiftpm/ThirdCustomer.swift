//
//  ThirdCustomer.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct ThirdCustomer: Customer {
    private let scene: GameScene
    private let customerSprite: CustomerSprite
    private let burgerSprite, friesSprite: FoodSprite
    private let position = CGPoint(x: 128, y: 240)
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "person4", pos: position)
        
        //Positions for three items
        let centerLeft = CGPoint(x: position.x - 55, y: position.y + 330)
        let centerRight = CGPoint(x: position.x + 60, y: position.y + 330)
        
        burgerSprite = FoodSprite(scene: scene, position: centerLeft, imageNamed: "burger")
        friesSprite = FoodSprite(scene: scene, position: centerRight, imageNamed: "fries")
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        let waitForFirstOrderDone = SKAction.wait(forDuration: 9.0)
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstOrderDone]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        let friesDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstOrderDone, CommonData.waitForFoodFade]
        friesSprite.startCompletionAnimation(friesDelay)
    }
    
    func runSTCFSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        // At t=9 this customer gets their order finished
        let waitForFirstOrderDone = SKAction.wait(forDuration: 6.0)
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstOrderDone]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        let friesDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstOrderDone, CommonData.waitForFoodFade]
        friesSprite.startCompletionAnimation(friesDelay)
    }
    
    func runRRSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        // At t=6, this customer gets one item in order completed
        let waitForFirstTurn = SKAction.wait(forDuration: 3.0)
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstTurn]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        //At t=15 this customer gets another turn
        let waitForSecondTurn = SKAction.wait(forDuration: 3.0)
        let friesDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstTurn, CommonData.waitForFoodFade, CommonData.waitForFoodFade, waitForSecondTurn]
        friesSprite.startCompletionAnimation(friesDelay)
    }
    
    func resetSprites() {
        burgerSprite.runActionOnAllSprites(CommonData.standardFadeOut)
        friesSprite.runActionOnAllSprites(CommonData.standardFadeOut)
        customerSprite.personSprite.run(CommonData.standardFadeOut)
        customerSprite.thoughtBubbleSprite.run(CommonData.standardFadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        for sprite in [burgerSprite, friesSprite] {
            sprite.startEntranceAnimation(delay)
        }
    }
}
