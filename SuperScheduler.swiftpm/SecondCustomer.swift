//
//  SecondCustomer.swift
//  SwiftStudentChallenge
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct SecondCustomer {
    private let scene: GameScene
    private let customerSprite: CustomerSprite
    private let drinkSprite: FoodSprite
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person4", pos: Constants.thirdCustomerPos)
        
        //Positions for item
        let center = CGPoint(x: Constants.thirdCustomerPos.x, y: Constants.thirdCustomerPos.y + 330)
        
        drinkSprite = FoodSprite(scene: scene, position: center, imageNamed: "swiftcan")
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        drinkSprite.runActionOnGraySprite(orderFadeIn)
        
        let waitForFirstOrderDone = SKAction.wait(forDuration: 6.0)
        
        let drinkStartDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone]
        drinkSprite.startCompletionAnimation(drinkStartDelay)
    }
    
    func runSTCFSim() {
        //Time after sim start
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        drinkSprite.runActionOnGraySprite(orderFadeIn)
        
        //Second customer has shortest order at t=3, so drink gets worked on
        let waitForFirstCustomerBurger = SKAction.wait(forDuration: 0)
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstCustomerBurger, Constants.foodFadeIn])
        drinkSprite.runActionOnColorSprite(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstCustomerBurger, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkSprite.runActionOnCheckmarkSprite(checkOnDrink)
        
        //Thats all for this customer
    }
    
    func runRRSim() {
        //Time after sim start
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        drinkSprite.runActionOnGraySprite(orderFadeIn)
        
        //Second customer has order at t=3, so drink gets worked on
        let waitForFirstCustomerBurger = SKAction.wait(forDuration: 0)
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstCustomerBurger, Constants.foodFadeIn])
        drinkSprite.runActionOnColorSprite(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstCustomerBurger, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkSprite.runActionOnCheckmarkSprite(checkOnDrink)
        
        //This customer is done
    }
    
    func resetSprites() {
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        drinkSprite.runActionOnAllSprites(fadeOut)
        customerSprite.personSprite.run(fadeOut)
        customerSprite.thoughtBubbleSprite.run(fadeOut)
    }
}
