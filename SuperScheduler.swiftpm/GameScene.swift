//
//  GameScene.swift
//  AppPlaygroundTest1
//
//  Created by Christopher Barlas on 2/15/24.
//

import SpriteKit

class GameScene: SKScene {
    
    private var firstCustomer: FirstCustomer!
    private var secondCustomer: SecondCustomer!
    private var thirdCustomer: ThirdCustomer!
    private var fourthCustomer: FourthCustomer!
    private var dialogueOverlay: DialogueOverlay!
    
    override func didMove(to view: SKView) {
        let background = SKTexture(imageNamed: "background3")
        background.filteringMode = .nearest
        let bgNode = SKSpriteNode(texture: background)
        addChild(bgNode)
        bgNode.position = CGPoint(x: 1024 / 2, y: 768 / 2)
        
        initSprites()
        
        dialogueOverlay = DialogueOverlay(scene: self)
        
        dialogueOverlay.startIntroDialog()
        
    }
    
    private func initSprites() {
        firstCustomer = FirstCustomer(scene: self)
        secondCustomer = SecondCustomer(scene: self)
        thirdCustomer = ThirdCustomer(scene: self)
        fourthCustomer = FourthCustomer(scene: self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let firstTouch = touches.first {
            dialogueOverlay.handleTouch(touch: firstTouch)
        }
    }
    
    func runFIFOSim() {
        firstCustomer.runFIFOSim()
        secondCustomer.runFIFOSim()
        thirdCustomer.runFIFOSim()
        fourthCustomer.runFIFOSim()
    }
    
    func showFIFODialog() {
        dialogueOverlay.showFIFODialog()
    }
    
    func showSTCFDialog() {
        dialogueOverlay.showSTCFDialog()
    }
    
    func runSTCFSim() {
        firstCustomer.runSTCFSim()
        secondCustomer.runSTCFSim()
        thirdCustomer.runSTCFSim()
        fourthCustomer.runSTCFSim()
    }
    
    func runRRSim() {
        firstCustomer.runRRSim()
        secondCustomer.runRRSim()
        thirdCustomer.runRRSim()
        fourthCustomer.runRRSim()
    }
    
    func showRRDialog() {
        dialogueOverlay.showRRDialog()
    }
    
    func resetCustomers() {
        firstCustomer.resetSprites()
        secondCustomer.resetSprites()
        thirdCustomer.resetSprites()
        fourthCustomer.resetSprites()
    }
}
