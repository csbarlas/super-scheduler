//
//  SecondCustomer.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/17/24.
//

import Foundation
import SpriteKit

struct SecondCustomer: Customer {
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
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
                
        let waitForFirstOrderDone = SKAction.wait(forDuration: 6.0)
        
        let drinkStartDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter, waitForFirstOrderDone]
        drinkSprite.startCompletionAnimation(drinkStartDelay)
    }
    
    func runSTCFSim() {
        //Time after sim start
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //Second customer has shortest order at t=3, so drink gets worked on
        let drinkDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        drinkSprite.startCompletionAnimation(drinkDelay)
        //Thats all for this customer
    }
    
    func runRRSim() {
        //Time after sim start
        let waitToEnter = SKAction.wait(forDuration: 3.0)
        let entranceDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        startEntranceAnimation(entranceDelay)
        
        //Second customer has order at t=3, so drink gets worked on
        let drinkDelay = [CommonData.waitForDialog, CommonData.standardWait, waitToEnter]
        drinkSprite.startCompletionAnimation(drinkDelay)
        
        //This customer is done
    }
    
    func resetSprites() {
        drinkSprite.runActionOnAllSprites(CommonData.standardFadeOut)
        customerSprite.personSprite.run(CommonData.standardFadeOut)
        customerSprite.thoughtBubbleSprite.run(CommonData.standardFadeOut)
    }
    
    private func startEntranceAnimation(_ delay: [SKAction]) {
        customerSprite.startEntranceAnimation(delay)
        drinkSprite.startEntranceAnimation(delay)
    }
}
