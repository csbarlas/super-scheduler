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
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person3", pos: Constants.fourthCustomerPos)
        
        //Positions for item
        let center = CGPoint(x: Constants.fourthCustomerPos.x, y: Constants.fourthCustomerPos.y + 330)
        
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
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        burgerSprite.runActionOnAllSprites(fadeOut)
        customerSprite.personSprite.run(fadeOut)
        customerSprite.thoughtBubbleSprite.run(fadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        burgerSprite.startEntranceAnimation(delay)
    }
}
