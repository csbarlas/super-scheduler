//
//  FourthCustomer.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct FourthCustomer: Customer {
    private let scene: GameScene
    private let customerSprite: CustomerSprite
    private let burgerSprite: FoodSprite
    private let position = CGPoint(x: 896, y: 240)
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "person2", pos: position)
        
        //Positions for item
        let center = CGPoint(x: position.x, y: position.y + 330)
        
        burgerSprite = FoodSprite(scene: scene, position: center, imageNamed: "burger")
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        let waitForOtherOrders = SKAction.wait(forDuration: 12.0)
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForOtherOrders]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        let showDialog = SKAction.run {
            scene.showFIFODialog()
        }
        
        let showDialogSeq = SKAction.sequence([CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForOtherOrders, CommonData.waitForFoodFade, CommonData.standardWait, showDialog])
        scene.run(showDialogSeq)
    }
    
    func runSTCFSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //At t=6 this customer has shortest order, gets worked on
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        burgerSprite.startCompletionAnimation(burgerDelay)
    }
    
    func runRRSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //At t=9 this customer has items in order, so gets one turn
        let waitForTurn = SKAction.wait(forDuration: 3.0)
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForTurn]
        burgerSprite.startCompletionAnimation(burgerDelay)
    }
    
    func resetSprites() {
        burgerSprite.runActionOnAllSprites(CommonData.standardFadeOut)
        customerSprite.personSprite.run(CommonData.standardFadeOut)
        customerSprite.thoughtBubbleSprite.run(CommonData.standardFadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        burgerSprite.startEntranceAnimation(delay)
    }
}
