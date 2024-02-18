//
//  DialogueOverlay.swift
//  SwiftStudentChallenge
//
//  Created by Christopher Barlas on 2/16/24.
//

import Foundation
import SpriteKit

struct DialogueOverlay {
    private let scene: GameScene
    
    private let employeeSprite, background: SKSpriteNode
    
    private var talkingBubbleSprite: SKLabelNode
    
    private let textBubbleSprite: SKSpriteNode
    
    private let yeahButton: SKSpriteNode
    
    private let STCFButton, RRButton: SKSpriteNode
    
    private var buttonNotPressed: SKSpriteNode!
    
    private var buttonPressCount = 0
    
    init(scene: GameScene) {
        self.scene = scene
        
        background = SKSpriteNode(color: .black, size: Constants.gameWindowSize)
        background.position = CGPoint(x: Constants.gameWindowSize.width / 2, y: Constants.gameWindowSize.height / 2)
        background.alpha = 0
        scene.addChild(background)
        
        employeeSprite = SKSpriteNode(imageNamed: "employee")
        employeeSprite.position = CGPoint(x: -192, y: 192)
        employeeSprite.texture?.filteringMode = .nearest
        employeeSprite.scale(to: CGSize(width: 384, height: 384))
        
        scene.addChild(employeeSprite)
        
        textBubbleSprite = SKSpriteNode(imageNamed: "textbubble")
        textBubbleSprite.position = CGPoint(x: 667, y: 475)
        textBubbleSprite.texture?.filteringMode = .nearest
        textBubbleSprite.scale(to: CGSize(width: 690, height: 512))
        textBubbleSprite.alpha = 0
        scene.addChild(textBubbleSprite)
        
        let cfURL = Bundle.main.url(forResource: "PublicPixel", withExtension: "ttf")! as CFURL
        //let _ = CTFontManagerRegisterFontURLs(cfURL, CTFontManagerScope.process, nil)
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let font = UIFont(name: "PublicPixel", size: 32.0)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : font!,
            .paragraphStyle : paragraphStyle,
            .foregroundColor : UIColor.black
        ]
        
        let attributedString = NSAttributedString(string: "Hi! I'm Bob, and feeling overwhelmed working the lunch hour rush. I need to find the best way to service the line of customers so they wait as little time as possible. Can you help me?", attributes: attributes)
        
        talkingBubbleSprite = SKLabelNode(attributedText: attributedString)
        talkingBubbleSprite.preferredMaxLayoutWidth = 550
        talkingBubbleSprite.numberOfLines = 0
        talkingBubbleSprite.verticalAlignmentMode = .top
        talkingBubbleSprite.alpha = 0
        
        talkingBubbleSprite.position = CGPoint(x: 700, y: 700)
        scene.addChild(talkingBubbleSprite)
        
        yeahButton = SKSpriteNode(imageNamed: "yeahbutton")
        yeahButton.name = "yeahbutton"
        yeahButton.position = CGPoint(x: 700, y: 150)
        yeahButton.alpha = 0
        yeahButton.texture?.filteringMode = .nearest
        scene.addChild(yeahButton)
        
        STCFButton = SKSpriteNode(imageNamed: "stcf-button")
        STCFButton.name = "stcfbutton"
        STCFButton.position = CGPoint(x: 550, y: 150)
        STCFButton.setScale(0.6)
        STCFButton.texture?.filteringMode = .nearest
        STCFButton.alpha = 0
        scene.addChild(STCFButton)
        
        RRButton = SKSpriteNode(imageNamed: "roundrobin-button")
        RRButton.name = "rrbutton"
        RRButton.position = CGPoint(x: 865, y: 150)
        RRButton.setScale(0.6)
        RRButton.texture?.filteringMode = .nearest
        RRButton.alpha = 0
        scene.addChild(RRButton)
        
    }
    
    private func showCommonDialogElements() {
        let dimScreenAction = SKAction.fadeAlpha(to: 0.5, duration: 1.0)
        
        let wait = SKAction.wait(forDuration: 1.5)
        let slideInAction = SKAction.move(to: CGPoint(x: 192, y: 192), duration: 1.0)
        slideInAction.timingMode = .easeInEaseOut
        let actionSequence = SKAction.sequence([wait, slideInAction])
        
        let textWait = SKAction.wait(forDuration: 2.5)
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let textActionSequence = SKAction.sequence([textWait, fadeInAction])
        
        background.run(dimScreenAction)
        employeeSprite.run(actionSequence)
        talkingBubbleSprite.run(textActionSequence)
        textBubbleSprite.run(textActionSequence)
    }
    
    func startIntroDialog() {
        showCommonDialogElements()
        
        let textWait = SKAction.wait(forDuration: 2.5)
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let textActionSequence = SKAction.sequence([textWait, fadeInAction])
        
        yeahButton.run(textActionSequence)
    }
    
    mutating func handleTouch(touch: UITouch, state: SimState) {
        let location = touch.location(in: scene)
        if let nodeAtTouch = self.scene.nodes(at: location).first {
            if nodeAtTouch.name == "yeahbutton" {
                buttonPressedAnimation(on: yeahButton)
                dismissOverlay(state: state)
                dismissIntroButtons(state: state)
                scene.runFIFOSim()
                buttonPressCount += 1
            } else if nodeAtTouch.name == "stcfbutton" {
                buttonPressedAnimation(on: STCFButton)
                buttonNotPressed = RRButton
                scene.resetCustomers()
                dismissOverlay(state: state)
                dismissFIFOButtons(state: state)
                scene.runSTCFSim()
                buttonPressCount += 1
            } else if nodeAtTouch.name == "rrbutton" {
                print("rr")
                buttonPressedAnimation(on: RRButton)
                buttonNotPressed = STCFButton
                scene.resetCustomers()
                dismissFIFOButtons(state: state)
                dismissOverlay(state: state)
                scene.runRRSim()
                buttonPressCount += 1
            }
        }
    }
    
    func buttonPressedAnimation(on: SKSpriteNode) {
        let startingScale = on.xScale
        
        let scaleUp = SKAction.scale(to: startingScale + 0.05, duration: 0)
        let wait = SKAction.wait(forDuration: 0.1)
        let scaleDown = SKAction.scale(to: startingScale, duration: 0)
        let actions = SKAction.sequence([scaleUp, wait, scaleDown])
        
        on.run(actions)
    }
    
    func dismissOverlay(state: SimState) {
        let brightenWait = SKAction.wait(forDuration: 2.5)
        let brightenScreen = SKAction.fadeAlpha(to: 0, duration: 1.0)
        let backgroundActions = SKAction.sequence([brightenWait, brightenScreen])
        
        let wait = SKAction.wait(forDuration: 1.5)
        let slideOutAction = SKAction.move(to: CGPoint(x: -192, y: 192), duration: 1.0)
        slideOutAction.timingMode = .easeInEaseOut
        let actionSequence = SKAction.sequence([wait, slideOutAction])
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
        let textActionSequence = SKAction.sequence([fadeOutAction])
        
        talkingBubbleSprite.run(textActionSequence)
        textBubbleSprite.run(textActionSequence)
        
        employeeSprite.run(actionSequence)
        
        background.run(backgroundActions)
    }
    
    func dismissIntroButtons(state: SimState) {
        let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
        yeahButton.run(fadeOutAction)
    }
    
    func dismissFIFOButtons(state: SimState) {
        let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
        STCFButton.run(fadeOutAction)
        RRButton.run(fadeOutAction)
    }
    
    mutating func showFIFODialog() {
        talkingBubbleSprite.removeFromParent()
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let font = UIFont(name: "PublicPixel", size: 26.0)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : font!,
            .paragraphStyle : paragraphStyle,
            .foregroundColor : UIColor.black
        ]
        
        let attributedString = NSAttributedString(string: "Serving orders in \"First In First Out\" order is easy to understand, but customers with small-sized orders wait for a long time if customers with large-sized orders are ahead! Do you have an idea how to improve things?", attributes: attributes)
        
        talkingBubbleSprite = SKLabelNode(attributedText: attributedString)
        talkingBubbleSprite.preferredMaxLayoutWidth = 550
        talkingBubbleSprite.numberOfLines = 0
        talkingBubbleSprite.verticalAlignmentMode = .top
        talkingBubbleSprite.alpha = 0
        
        talkingBubbleSprite.position = CGPoint(x: 700, y: 700)
        scene.addChild(talkingBubbleSprite)
        
        showCommonDialogElements()
        
        showApppropriateButtons()
    }
    
    mutating func showSTCFDialog() {
        talkingBubbleSprite.removeFromParent()
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let font = UIFont(name: "PublicPixel", size: 26.0)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : font!,
            .paragraphStyle : paragraphStyle,
            .foregroundColor : UIColor.black
        ]
        
        let attributedString = NSAttributedString(string: "By always completing the shortest orders first, we were able to service customers with small orders even when a large order was put in first! But now if a continuous stream of small orders come in, large orders never get serviced leading to starvation! How could we fix that?", attributes: attributes)
        
        talkingBubbleSprite = SKLabelNode(attributedText: attributedString)
        talkingBubbleSprite.preferredMaxLayoutWidth = 550
        talkingBubbleSprite.numberOfLines = 0
        talkingBubbleSprite.verticalAlignmentMode = .top
        talkingBubbleSprite.alpha = 0
        
        talkingBubbleSprite.position = CGPoint(x: 700, y: 700)
        scene.addChild(talkingBubbleSprite)
        
        showCommonDialogElements()
        
        showApppropriateButtons()
    }
    
    mutating func showRRDialog() {
        talkingBubbleSprite.removeFromParent()
        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let font = UIFont(name: "PublicPixel", size: 26.0)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font : font!,
            .paragraphStyle : paragraphStyle,
            .foregroundColor : UIColor.black
        ]
        
        let attributedString = NSAttributedString(string: "By servicing orders in a cycle giving each customer one item of their order, we can increase the interactivity with each customer even if the wait time doesn't decrease. Customers are happy as they consistently get one item of their order and feel progress is being made!", attributes: attributes)
        
        talkingBubbleSprite = SKLabelNode(attributedText: attributedString)
        talkingBubbleSprite.preferredMaxLayoutWidth = 550
        talkingBubbleSprite.numberOfLines = 0
        talkingBubbleSprite.verticalAlignmentMode = .top
        talkingBubbleSprite.alpha = 0
        
        talkingBubbleSprite.position = CGPoint(x: 700, y: 700)
        scene.addChild(talkingBubbleSprite)
        
        showCommonDialogElements()
        
        showApppropriateButtons()
    }
    
    func showApppropriateButtons() {
        let textWait = SKAction.wait(forDuration: 2.5)
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let textActionSequence = SKAction.sequence([textWait, fadeInAction])
        
        if (buttonPressCount == 1) {
            RRButton.run(textActionSequence)
            STCFButton.run(textActionSequence)
        } else if (buttonPressCount == 2) {
            buttonNotPressed.run(textActionSequence)
        } else {
            yeahButton.run(textActionSequence)
        }
    }
}
