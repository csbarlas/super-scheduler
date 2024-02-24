//
//  FirstCustomer.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct FirstCustomer: Customer {
    private let scene: GameScene
    private let customerSprite: CustomerSprite
    private let burgerSprite, friesSprite, drinkSprite: FoodSprite
    private let position: CGPoint = CGPoint(x: 384, y: 240)
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "person1", pos: position)
        
        //Positions for three items
        let topLeft = CGPoint(x: position.x - 55, y: position.y + 360)
        let topRight = CGPoint(x: position.x + 60, y: position.y + 360)
        let bottomCenter = CGPoint(x: position.x, y: position.y + 295)
        
        burgerSprite = FoodSprite(scene: scene, position: topLeft, imageNamed: "burger")
        friesSprite = FoodSprite(scene: scene, position: topRight, imageNamed: "fries")
        drinkSprite = FoodSprite(scene: scene, position: bottomCenter, imageNamed: "swiftcan")
    }
    
    func runFIFOSim() {
        //Show customer
        startEntranceAnimation([CommonData.waitForDialog])
        
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        let friesDelay = [CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade]
        friesSprite.startCompletionAnimation(friesDelay)
        
        let drinkDelay = [CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, CommonData.waitForFoodFade]
        drinkSprite.startCompletionAnimation(drinkDelay)
    }
    
    func runSTCFSim() {
        //Show customer
        startEntranceAnimation([CommonData.waitForDialog])
        
        //Only burger completes before two new customers enter
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait]
        burgerSprite.startCompletionAnimation(burgerDelay)
        // Done at t=3
        
        //At t=15, this customer starts getting serviced
        let waitForTurn = SKAction.wait(forDuration: 12.0)
        
        let friesDelay = [CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, waitForTurn]
        friesSprite.startCompletionAnimation(friesDelay)
        
        let drinkDelay = [CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, waitForTurn, CommonData.waitForFoodFade]
        drinkSprite.startCompletionAnimation(drinkDelay)
        
        let showSTCFDialog = SKAction.run {
            scene.showSTCFDialog()
        }
        
        let showDialogSeq = SKAction.sequence([CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, waitForTurn, CommonData.waitForFoodFade, CommonData.waitForFoodFade, showSTCFDialog])
        scene.run(showDialogSeq)
    }
    
    func runRRSim() {
        //TODO: I think there used to be an error here
        //Show customer
        startEntranceAnimation([CommonData.waitForDialog])
        
        //Only burger completes before two new customers enter and they get their turn
        let burgerDelay = [CommonData.waitForDialog, CommonData.standardWait]
        burgerSprite.startCompletionAnimation(burgerDelay)
        
        //At t=12, this customer gets another turn
        let waitForTurn = SKAction.wait(forDuration: 9.0)
        let friesDelay = [CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, waitForTurn]
        friesSprite.startCompletionAnimation(friesDelay)
        
        //At t=18 this customer gets last turn
        let waitForLastTurn = SKAction.wait(forDuration: 3.0)
        let drinkDelay = [CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, waitForTurn, CommonData.waitForFoodFade, CommonData.waitForFoodFade]
        drinkSprite.startCompletionAnimation(drinkDelay)
        
        let showSTCFDialog = SKAction.run {
            scene.showRRDialog()
        }
        
        let showDialogSeq = SKAction.sequence([CommonData.waitForDialog, CommonData.standardWait, CommonData.waitForFoodFade, waitForTurn, CommonData.waitForFoodFade, CommonData.waitForFoodFade, CommonData.waitForFoodFade, showSTCFDialog])
        scene.run(showDialogSeq)
    }
    
    func resetSprites() {
        let spritesToFade = [burgerSprite, friesSprite, drinkSprite]
        for sprite in spritesToFade {
            sprite.runActionOnAllSprites(CommonData.standardFadeOut)
        }
        customerSprite.personSprite.run(CommonData.standardFadeOut)
        customerSprite.thoughtBubbleSprite.run(CommonData.standardFadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        for sprite in [burgerSprite, friesSprite, drinkSprite] {
            sprite.startEntranceAnimation(delay)
        }
    }
}
