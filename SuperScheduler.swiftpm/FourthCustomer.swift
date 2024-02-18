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
    
    private let burgerSprite: SKSpriteNode
    private let burgerGray: SKSpriteNode
    
    private let burgerCheck: SKSpriteNode
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "Person3", pos: Constants.fourthCustomerPos)
        
        let foodSpriteSize = CGSize(width: 90, height: 90)
        let checkmarkSpriteSize = CGSize(width: 110, height: 110)
        
        //Positions for three items
        let center = CGPoint(x: Constants.fourthCustomerPos.x, y: Constants.fourthCustomerPos.y + 330)
        
        burgerSprite = SKSpriteNode(imageNamed: "burger")
        burgerSprite.texture?.filteringMode = .nearest
        burgerSprite.scale(to: foodSpriteSize)
        burgerSprite.position = center
        burgerSprite.alpha = 0
        
        burgerGray = SKSpriteNode(imageNamed: "burger-gray")
        burgerGray.texture?.filteringMode = .nearest
        burgerGray.scale(to: foodSpriteSize)
        burgerGray.position = center
        burgerGray.alpha = 0
        
        burgerCheck = SKSpriteNode(imageNamed: "checkmark")
        burgerCheck.texture?.filteringMode = .nearest
        burgerCheck.scale(to: checkmarkSpriteSize)
        burgerCheck.position = center
        burgerCheck.alpha = 0
        
        scene.addChild(burgerGray)
        scene.addChild(burgerSprite)
        scene.addChild(burgerCheck)
    }
    
    func runFIFOSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerGray.run(orderFadeIn)
        
        let waitForOtherOrders = SKAction.wait(forDuration: 12.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders, Constants.foodFadeIn])
        burgerSprite.run(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForOtherOrders, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerCheck.run(checkOnBurger)
        
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
        burgerGray.run(orderFadeIn)
        
        //At t=6 this customer has shortest order, gets worked on
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.foodFadeIn])
        burgerSprite.run(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerCheck.run(checkOnBurger)
    }
    
    func runRRSim() {
        let waitToEnter = SKAction.wait(forDuration: 6.0)
        
        //Show customer
        customerSprite.personSprite.run(SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn]))
        
        //Then thought bubble and order
        let orderFadeIn = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, Constants.standardFadeIn])
        customerSprite.thoughtBubbleSprite.run(orderFadeIn)
        burgerGray.run(orderFadeIn)
        
        //At t=9 this customer has items in order, so gets one turn
        let waitForTurn = SKAction.wait(forDuration: 3.0)
        let burgerDone = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForTurn, Constants.foodFadeIn])
        burgerSprite.run(burgerDone)
        
        let checkOnBurger = SKAction.sequence([Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForTurn, Constants.waitForFoodFade, Constants.checkmarkFade])
        burgerCheck.run(checkOnBurger)
    }
    
    func resetSprites() {
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        let spritesToFade = [burgerCheck, burgerSprite, burgerGray]
        for sprite in spritesToFade {
            sprite.run(fadeOut)
        }
        customerSprite.personSprite.run(fadeOut)
        customerSprite.thoughtBubbleSprite.run(fadeOut)
    }
}
