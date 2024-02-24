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
    private let position = CGPoint(x: 640, y: 240)
    
    init(scene: GameScene) {
        self.scene = scene
        customerSprite = CustomerSprite(scene: scene, customerTexture: "person3", pos: position)
        
        //Positions for item
        let center = CGPoint(x: position.x, y: position.y + 330)
        
        drinkSprite = FoodSprite(scene: scene, position: center, imageNamed: "swiftcan")
    }
    
    func runFIFOSim() {
        //Show customer
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
                
        let waitForFirstOrderDone = SKAction.wait(forDuration: 6.0)
        
        let drinkStartDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter, waitForFirstOrderDone]
        drinkSprite.startCompletionAnimation(drinkStartDelay)
    }
    
    func runSTCFSim() {
        //Time after sim start
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //Second customer has shortest order at t=3, so drink gets worked on
        let drinkDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        drinkSprite.startCompletionAnimation(drinkDelay)
        //Thats all for this customer
    }
    
    func runRRSim() {
        //Time after sim start
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //Second customer has order at t=3, so drink gets worked on
        let drinkDelay = [Constants.waitForDialog, Constants.standardWait, waitToEnter]
        drinkSprite.startCompletionAnimation(drinkDelay)
        
        //This customer is done
    }
    
    func resetSprites() {
        drinkSprite.runActionOnAllSprites(Constants.standardFadeOut)
        customerSprite.personSprite.run(Constants.standardFadeOut)
        customerSprite.thoughtBubbleSprite.run(Constants.standardFadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        drinkSprite.startEntranceAnimation(delay)
    }
}
