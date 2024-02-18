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
    
    private let drinkSprite: SKSpriteNode
    private let grayDrink: SKSpriteNode
    private let drinkCheck: SKSpriteNode
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person4", pos: Constants.thirdCustomerPos)
        
        let foodSpriteSize = CGSize(width: 90, height: 90)
        
        //Positions for three items
        let center = CGPoint(x: Constants.thirdCustomerPos.x, y: Constants.thirdCustomerPos.y + 330)
        
        drinkSprite = SKSpriteNode(imageNamed: "swiftcan")
        drinkSprite.texture?.filteringMode = .nearest
        drinkSprite.scale(to: foodSpriteSize)
        drinkSprite.position = center
        drinkSprite.alpha = 0
        
        grayDrink = SKSpriteNode(imageNamed: "swiftcan-gray")
        grayDrink.texture?.filteringMode = .nearest
        grayDrink.scale(to: foodSpriteSize)
        grayDrink.position = center
        grayDrink.alpha = 0
        
        drinkCheck = SKSpriteNode(imageNamed: "checkmark")
        drinkCheck.texture?.filteringMode = .nearest
        drinkCheck.scale(to: Constants.checkmarkSpriteSize)
        drinkCheck.position = center
        drinkCheck.alpha = 0
        
        scene.addChild(grayDrink)
        scene.addChild(drinkSprite)
        scene.addChild(drinkCheck)
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        grayDrink.run(orderFadeIn)
        
        let waitForFirstOrderDone = SKAction.wait(forDuration: 6.0)
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.foodFadeIn])
        drinkSprite.run(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkCheck.run(checkOnDrink)
    }
}

