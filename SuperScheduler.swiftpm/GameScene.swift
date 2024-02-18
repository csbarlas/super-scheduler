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
    
    private var simState: SimState = .Intro
    
    override func didMove(to view: SKView) {
        let background = SKTexture(imageNamed: "background")
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
            dialogueOverlay.handleTouch(touch: firstTouch, state: simState)
        }
    }
    
    func runFIFOSim() {
        simState = .FIFO
        firstCustomer.runFIFOSim()
        secondCustomer.runFIFOSim()
        thirdCustomer.runFIFOSim()
        fourthCustomer.runFIFOSim()
    }
    
    func showFIFODialog() {
        dialogueOverlay.showFIFODialog()
    }
}
