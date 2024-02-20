//
//  ThirdCustomer.swift
//  SwiftStudentChallenge
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct ThirdCustomer {
    private let scene: GameScene
    private let customerSprite: CustomerSprite
    private let burgerSprite, friesSprite: FoodSprite
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person1", pos: Constants.firstCustomerPos)
        
        //Positions for three items
        let centerLeft = CGPoint(x: Constants.firstCustomerPos.x - 55, y: Constants.firstCustomerPos.y + 330)
        let centerRight = CGPoint(x: Constants.firstCustomerPos.x + 60, y: Constants.firstCustomerPos.y + 330)
        
        burgerSprite = FoodSprite(scene: scene, position: centerLeft, imageNamed: "burger")
        friesSprite = FoodSprite(scene: scene, position: centerRight, imageNamed: "fries")
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        friesSprite.runActionOnGraySprite(orderFadeIn)
        
        let waitForFirstOrderDone = SKAction.wait(forDuration: 9.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.foodFadeIn])
        friesSprite.runActionOnColorSprite(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesSprite.runActionOnCheckmarkSprite(checkOnFries)
    }
    
    func runSTCFSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        
        let newSeq = orderFadeIn
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        friesSprite.runActionOnGraySprite(orderFadeIn)
        
        // At t=9 this customer gets their order finished
        let waitForFirstOrderDone = SKAction.wait(forDuration: 6.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.foodFadeIn])
        friesSprite.runActionOnColorSprite(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesSprite.runActionOnCheckmarkSprite(checkOnFries)
    }
    
    func runRRSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        friesSprite.runActionOnGraySprite(orderFadeIn)
        
        // At t=6, this customer gets one item in order completed
        let waitForFirstTurn = SKAction.wait(forDuration: 3.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstTurn, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstTurn, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        
        //At t=15 this customer gets another turn
        let waitForSecondTurn = SKAction.wait(forDuration: 3.0)
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, waitForSecondTurn, Constants.foodFadeIn])
        friesSprite.runActionOnColorSprite(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstTurn, Constants.waitForFoodFade, Constants.waitForFoodFade, waitForSecondTurn, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesSprite.runActionOnCheckmarkSprite(checkOnFries)
    }
    
    func resetSprites() {
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        burgerSprite.runActionOnAllSprites(fadeOut)
        friesSprite.runActionOnAllSprites(fadeOut)
        customerSprite.personSprite.run(fadeOut)
        customerSprite.thoughtBubbleSprite.run(fadeOut)
    }
}
