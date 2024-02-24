//
//  FourthCustomer.swift
//  SwiftStudentChallenge
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct FourthCustomer {
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
        let entranceDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        let waitForOtherOrders = SKAction.wait(forDuration: 12.0)
        let burgerDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        let showDialog = SKAction.run {
            scene.showFIFODialog()
        }
        
        let showDialogSeq = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders, Constants.waitForFoodFade, Constants.standardWait, showDialog])
        scene.run(showDialogSeq)
    }
    
    func runSTCFSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        let entranceDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //At t=6 this customer has shortest order, gets worked on
        let burgerDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        burgerSprite.startCompletionAnimation(burgerDelay)
    }
    
    func runRRSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        let entranceDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //At t=9 this customer has items in order, so gets one turn
        let waitForTurn = SKAction.wait(forDuration: 3.0)
        let burgerDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForTurn]
        burgerSprite.startCompletionAnimation(burgerDelay)
    }
    
    func resetSprites() {
        burgerSprite.runActionOnAllSprites(Constants.standardFadeOut)
        customerSprite.personSprite.run(Constants.standardFadeOut)
        customerSprite.thoughtBubbleSprite.run(Constants.standardFadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        burgerSprite.startEntranceAnimation(delay)
    }
}
