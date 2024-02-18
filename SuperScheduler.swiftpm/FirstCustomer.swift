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
    
    private let burgerSprite, friesSprite, drinkSprite: SKSpriteNode
    private let burgerCheck, friesCheck, drinkCheck: SKSpriteNode
    private let grayBurger, grayFries, grayDrink: SKSpriteNode
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person2", pos: Constants.secondCustomerPos)
        
        let foodSpriteSize = CGSize(width: 90, height: 90)
        let checkmarkSpriteSize = CGSize(width: 110, height: 110)
        
        //Positions for three items
        let topLeft = CGPoint(x: Constants.secondCustomerPos.x - 55, y: Constants.secondCustomerPos.y + 360)
        let topRight = CGPoint(x: Constants.secondCustomerPos.x + 60, y: Constants.secondCustomerPos.y + 360)
        let bottomCenter = CGPoint(x: Constants.secondCustomerPos.x, y: Constants.secondCustomerPos.y + 295)
        
        
        burgerSprite = SKSpriteNode(imageNamed: "burger")
        burgerSprite.texture?.filteringMode = .nearest
        burgerSprite.scale(to: foodSpriteSize)
        burgerSprite.position = topLeft
        burgerSprite.alpha = 0
        
        grayBurger = SKSpriteNode(imageNamed: "burger-gray")
        grayBurger.texture?.filteringMode = .nearest
        grayBurger.scale(to: foodSpriteSize)
        grayBurger.position = topLeft
        grayBurger.alpha = 0
        
        friesSprite = SKSpriteNode(imageNamed: "fries")
        friesSprite.texture?.filteringMode = .nearest
        friesSprite.scale(to: foodSpriteSize)
        friesSprite.position = topRight
        friesSprite.alpha = 0
        
        grayFries = SKSpriteNode(imageNamed: "fries-gray")
        grayFries.texture?.filteringMode = .nearest
        grayFries.scale(to: foodSpriteSize)
        grayFries.position = topRight
        grayFries.alpha = 0
        
        drinkSprite = SKSpriteNode(imageNamed: "swiftcan")
        drinkSprite.texture?.filteringMode = .nearest
        drinkSprite.scale(to: foodSpriteSize)
        drinkSprite.position = bottomCenter
        drinkSprite.alpha = 0
        
        grayDrink = SKSpriteNode(imageNamed: "swiftcan-gray")
        grayDrink.texture?.filteringMode = .nearest
        grayDrink.scale(to: foodSpriteSize)
        grayDrink.position = bottomCenter
        grayDrink.alpha = 0
        
        burgerCheck = SKSpriteNode(imageNamed: "checkmark")
        burgerCheck.texture?.filteringMode = .nearest
        burgerCheck.scale(to: checkmarkSpriteSize)
        burgerCheck.position = topLeft
        burgerCheck.alpha = 0
        
        friesCheck = SKSpriteNode(imageNamed: "checkmark")
        friesCheck.texture?.filteringMode = .nearest
        friesCheck.scale(to: checkmarkSpriteSize)
        friesCheck.position = topRight
        friesCheck.alpha = 0
        
        drinkCheck = SKSpriteNode(imageNamed: "checkmark")
        drinkCheck.texture?.filteringMode = .nearest
        drinkCheck.scale(to: checkmarkSpriteSize)
        drinkCheck.position = bottomCenter
        drinkCheck.alpha = 0
        
        scene.addChild(grayBurger)
        scene.addChild(grayFries)
        scene.addChild(grayDrink)
        
        scene.addChild(burgerSprite)
        scene.addChild(friesSprite)
        scene.addChild(drinkSprite)
        
        scene.addChild(burgerCheck)
        scene.addChild(friesCheck)
        scene.addChild(drinkCheck)
    }
    
    func runFIFOSim() {
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        grayBurger.run(orderFadeIn)
        grayFries.run(orderFadeIn)
        grayDrink.run(orderFadeIn)
        
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.foodFadeIn])
        burgerSprite.run(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerCheck.run(checkOnBurger)
        
        let friesDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.foodFadeIn])
        friesSprite.run(friesDone)
        
        let checkOnFries = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        friesCheck.run(checkOnFries)
        
        let drinkDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.foodFadeIn])
        drinkSprite.run(drinkDone)
        
        let checkOnDrink = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.waitForFoodFade, Constants.checkmarkFade])
        drinkCheck.run(checkOnDrink)
    }
}
