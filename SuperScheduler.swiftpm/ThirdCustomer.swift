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
    
    private let burgerSprite, friesSprite: SKSpriteNode
    private let grayBurger, grayFries: SKSpriteNode
    private let burgerCheck, friesCheck: SKSpriteNode
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person1", pos: Constants.firstCustomerPos)
        
        let foodSpriteSize = CGSize(width: 90, height: 90)
        
        //Positions for three items
        let centerLeft = CGPoint(x: Constants.firstCustomerPos.x - 55, y: Constants.firstCustomerPos.y + 330)
        let centerRight = CGPoint(x: Constants.firstCustomerPos.x + 60, y: Constants.firstCustomerPos.y + 330)
        
        burgerSprite = SKSpriteNode(imageNamed: "burger")
        burgerSprite.texture?.filteringMode = .nearest
        burgerSprite.scale(to: foodSpriteSize)
        burgerSprite.position = centerLeft
        burgerSprite.alpha = 0
        
        grayBurger = SKSpriteNode(imageNamed: "burger-gray")
        grayBurger.texture?.filteringMode = .nearest
        grayBurger.scale(to: foodSpriteSize)
        grayBurger.position = centerLeft
        grayBurger.alpha = 0
        
        burgerCheck = SKSpriteNode(imageNamed: "checkmark")
        burgerCheck.texture?.filteringMode = .nearest
        burgerCheck.scale(to: Constants.checkmarkSpriteSize)
        burgerCheck.position = centerLeft
        burgerCheck.alpha = 0
        
        friesSprite = SKSpriteNode(imageNamed: "fries")
        friesSprite.texture?.filteringMode = .nearest
        friesSprite.scale(to: foodSpriteSize)
        friesSprite.position = centerRight
        friesSprite.alpha = 0
        
        grayFries = SKSpriteNode(imageNamed: "fries-gray")
        grayFries.texture?.filteringMode = .nearest
        grayFries.scale(to: foodSpriteSize)
        grayFries.position = centerRight
        grayFries.alpha = 0
        
        friesCheck = SKSpriteNode(imageNamed: "checkmark")
        friesCheck.texture?.filteringMode = .nearest
        friesCheck.scale(to: Constants.checkmarkSpriteSize)
        friesCheck.position = centerRight
        friesCheck.alpha = 0
        
        scene.addChild(grayBurger)
        scene.addChild(grayFries)
        
        scene.addChild(burgerSprite)
        scene.addChild(friesSprite)
        
        scene.addChild(burgerCheck)
        scene.addChild(friesCheck)
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        grayBurger.run(orderFadeIn)
        grayFries.run(orderFadeIn)
        
        let waitForFirstOrderDone = SKAction.wait(forDuration: 9.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.foodFadeIn])
        burgerSprite.run(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerCheck.run(checkOnBurger)
        
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.foodFadeIn])
        friesSprite.run(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesCheck.run(checkOnFries)
    }
}
