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
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        friesSprite.runActionOnGraySprite(orderFadeIn)
        drinkSprite.runActionOnGraySprite(orderFadeIn)
        
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.foodFadeIn])
        friesSprite.runActionOnColorSprite(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesSprite.runActionOnCheckmarkSprite(checkOnFries)
        
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.foodFadeIn])
        drinkSprite.runActionOnColorSprite(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkSprite.runActionOnCheckmarkSprite(checkOnDrink)
    }
    
    func runSTCFSim() {
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        friesSprite.runActionOnGraySprite(orderFadeIn)
        drinkSprite.runActionOnGraySprite(orderFadeIn)
        
        //Only burger completes before two new customers enter
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        // Done at t=3
        
        //At t=15, this customer starts getting serviced
        let waitForTurn = SKAction.wait(forDuration: 12.0)
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.foodFadeIn])
        friesSprite.runActionOnColorSprite(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesSprite.runActionOnCheckmarkSprite(checkOnFries)
        
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.foodFadeIn])
        drinkSprite.runActionOnColorSprite(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkSprite.runActionOnCheckmarkSprite(checkOnDrink)
        
        let showSTCFDialog = SKAction.run {
            scene.showSTCFDialog()
        }
        
        let showDialogSeq = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, showSTCFDialog])
        scene.run(showDialogSeq)
    }
    
    func runRRSim() {
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        friesSprite.runActionOnGraySprite(orderFadeIn)
        drinkSprite.runActionOnGraySprite(orderFadeIn)
        
        //Only burger completes before two new customers enter and they get their turn
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        
        //At t=12, this customer gets another turn
        let waitForTurn = SKAction.wait(forDuration: 9.0)
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.foodFadeIn])
        friesSprite.runActionOnColorSprite(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesSprite.runActionOnCheckmarkSprite(checkOnFries)
        
        //At t=18 this customer gets last turn
        let waitForLastTurn = SKAction.wait(forDuration: 3.0)
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.foodFadeIn])
        drinkSprite.runActionOnColorSprite(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, waitForTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkSprite.runActionOnCheckmarkSprite(checkOnDrink)
        
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
}
