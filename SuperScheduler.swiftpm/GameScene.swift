//
//  GameScene.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/15/24.
//

import SpriteKit

class GameScene: SKScene {
    private var customers = [Customer]()
    private var dialogueOverlay: DialogueOverlay!
    
    override func didMove(to view: SKView) {
        let background = SKTexture(imageNamed: "background3")
        background.filteringMode = .nearest
        let bgNode = SKSpriteNode(texture: background)
        addChild(bgNode)
        bgNode.position = CommonData.gameWindowCenter
        
        customers.append(FirstCustomer(scene: self))
        customers.append(SecondCustomer(scene: self))
        customers.append(ThirdCustomer(scene: self))
        customers.append(FourthCustomer(scene: self))
        
        dialogueOverlay = DialogueOverlay(scene: self)
        dialogueOverlay.startIntroDialog()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            dialogueOverlay.handleTouch(touch: firstTouch)
        }
    }
    
    func runFIFOSim() {
        customers.forEach{ customer in
            customer.runFIFOSim()
        }
    }

    func runSTCFSim() {
        customers.forEach{ customer in
            customer.runSTCFSim()
        }
    }
    
    func runRRSim() {
        customers.forEach{ customer in
            customer.runRRSim()
        }
    }
    
    func showFIFODialog() {
        dialogueOverlay.showFIFODialog()
    }
    
    func showRRDialog() {
        dialogueOverlay.showRRDialog()
    }

    func showSTCFDialog() {
        dialogueOverlay.showSTCFDialog()
    }
    
    func resetCustomers() {
        customers.forEach{ customer in
            customer.resetSprites()
        }
    }
}
