//
//  FirstCustomer.swift
//  SwiftStudentChallenge
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct FirstCustomer {
    private let scene: GameScene
    
    private let customerSprite: CustomerSprite
    
    private let burgerSprite, friesSprite, drinkSprite: FoodSprite
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person2", pos: Constants.secondCustomerPos)
        
        //Positions for three items
        let topLeft = CGPoint(x: Constants.secondCustomerPos.x - 55, y: Constants.secondCustomerPos.y + 360)
        let topRight = CGPoint(x: Constants.secondCustomerPos.x + 60, y: Constants.secondCustomerPos.y + 360)
        let bottomCenter = CGPoint(x: Constants.secondCustomerPos.x, y: Constants.secondCustomerPos.y + 295)
        
        burgerSprite = FoodSprite(scene: scene, position: topLeft, imageNamed: "burger")
        friesSprite = FoodSprite(scene: scene, position: topRight, imageNamed: "fries")
        drinkSprite = FoodSprite(scene: scene, position: bottomCenter, imageNamed: "swiftcan")
    }
    
    func runFIFOSim() {
        //Show customer
        startEntranceAnimation([Constants.waitForDialog])
        
        let burgerDelay = [Constants.waitForDialog, Constants.standardWait]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        let friesDelay = [Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade]
        friesSprite.startCompletionAnimation(friesDelay)
        
        let drinkDelay = [Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade]
        drinkSprite.startCompletionAnimation(drinkDelay)
    }
    
    func runSTCFSim() {
        //Show customer
        startEntranceAnimation([Constants.waitForDialog])
        
        //Only burger completes before two new customers enter
        let burgerDelay = [Constants.waitForDialog, Constants.standardWait]
        burgerSprite.startCompletionAnimation(burgerDelay)
        // Done at t=3
        
        //At t=15, this customer starts getting serviced
        let waitForTurn = SKAction.wait(forDuration: 12.0)
        
        let friesDelay = [Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn]
        friesSprite.startCompletionAnimation(friesDelay)
        
        let drinkDelay = [Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade]
        drinkSprite.startCompletionAnimation(drinkDelay)
        
        let showSTCFDialog = SKAction.run {
            scene.showSTCFDialog()
        }
        
        let showDialogSeq = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, showSTCFDialog])
        scene.run(showDialogSeq)
    }
    
    func runRRSim() {
        //TODO: I think there used to be an error here
        //Show customer
        startEntranceAnimation([Constants.waitForDialog])
        
        //Only burger completes before two new customers enter and they get their turn
        let burgerDelay = [Constants.waitForDialog, Constants.standardWait]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        //At t=12, this customer gets another turn
        let waitForTurn = SKAction.wait(forDuration: 9.0)
        let friesDelay = [Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn]
        friesSprite.startCompletionAnimation(friesDelay)
        
        //At t=18 this customer gets last turn
        let waitForLastTurn = SKAction.wait(forDuration: 3.0)
        let drinkDelay = [Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade]
        drinkSprite.startCompletionAnimation(drinkDelay)
        
        let showSTCFDialog = SKAction.run {
            scene.showRRDialog()
        }
        
        let showDialogSeq = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.waitForFoodFade, showSTCFDialog])
        scene.run(showDialogSeq)
    }
    
    func resetSprites() {
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        let spritesToFade = [burgerSprite, friesSprite, drinkSprite]
        for sprite in spritesToFade {
            sprite.runActionOnAllSprites(fadeOut)
        }
        customerSprite.personSprite.run(fadeOut)
        customerSprite.thoughtBubbleSprite.run(fadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        for sprite in [burgerSprite, friesSprite, drinkSprite] {
            sprite.startEntranceAnimation(delay)
        }
    }
}
