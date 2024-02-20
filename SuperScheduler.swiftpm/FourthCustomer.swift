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
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        
        let waitForOtherOrders = SKAction.wait(forDuration: 12.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
        
        let showDialog = SKAction.run {
            scene.showFIFODialog()
        }
        
        let showDialogSeq = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders, Constants.waitForFoodFade, Constants.standardWait, showDialog])
        scene.run(showDialogSeq)
    }
    
    func runSTCFSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        
        //At t=6 this customer has shortest order, gets worked on
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
    }
    
    func runRRSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerSprite.runActionOnGraySprite(orderFadeIn)
        
        //At t=9 this customer has items in order, so gets one turn
        let waitForTurn = SKAction.wait(forDuration: 3.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForTurn, Constants.foodFadeIn])
        burgerSprite.runActionOnColorSprite(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForTurn, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerSprite.runActionOnCheckmarkSprite(checkOnBurger)
    }
    
    func resetSprites() {
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        burgerSprite.runActionOnAllSprites(fadeOut)
        customerSprite.personSprite.run(fadeOut)
        customerSprite.thoughtBubbleSprite.run(fadeOut)
    }
}
