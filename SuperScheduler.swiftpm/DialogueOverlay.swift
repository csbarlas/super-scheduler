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
    private let employeeSprite, background, textBubbleSprite, yeahButton, STCFButton, RRButton: SKSpriteNode
    private var textSprite: SKLabelNode
    private var buttonNotPressed: SKSpriteNode!
    private var buttonPressCount = 0
    private var paragraphStyle = NSMutableParagraphStyle()
    private var font: UIFont
    private var attributes: [NSAttributedString.Key: Any]
    private var attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "")
    private let fifoText = "Serving orders in \"First In First Out\" order is easy to understand, but customers with small-sized orders wait for a long time if customers with large-sized orders are ahead! Do you have an idea how to improve things?"
    private let stcfText = "By always completing the shortest orders first, we were able to service customers with small orders even when a large order was put in first! But now if a continuous stream of small orders come in, large orders never get serviced leading to starvation! How could we fix that?"
    private let rrText = "By servicing orders in a cycle giving each customer one item of their order, we can increase the interactivity with each customer even if the wait time doesn't decrease. Customers are happy as they consistently get one item of their order and feel progress is being made!"
    
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
        
        paragraphStyle =  NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.center
        paragraphStyle.lineBreakMode = .byWordWrapping
        let cfURL = Bundle.main.url(forResource: "PublicPixel", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        font = UIFont(name: "PublicPixel", size: 26.0) ?? UIFont.systemFont(ofSize: 26.0)
        attributes = [
                .font : font,
                .paragraphStyle : paragraphStyle,
                .foregroundColor : UIColor.black
            ]
        
        let introText = "Hi! I'm Bob, and feeling overwhelmed working the lunch hour rush. I need to find the best way to service the line of customers so they wait as little time as possible. Can you help me?"
        attributedString.mutableString.setString(introText)
        attributedString.setAttributes(attributes, range: NSMakeRange(0, introText.count))
        textSprite = SKLabelNode(attributedText: attributedString)
        textSprite.preferredMaxLayoutWidth = 550
        textSprite.numberOfLines = 0
        textSprite.verticalAlignmentMode = .top
        textSprite.alpha = 0
        textSprite.position = CGPoint(x: 700, y: 700)
        scene.addChild(textSprite)
        
        yeahButton = SKSpriteNode(imageNamed: "yeahbutton")
        yeahButton.name = "yeahbutton"
        yeahButton.position = CGPoint(x: 700, y: 150)
        yeahButton.texture?.filteringMode = .nearest
        yeahButton.alpha = 0
        
        STCFButton = SKSpriteNode(imageNamed: "stcf-button")
        STCFButton.name = "stcfbutton"
        STCFButton.position = CGPoint(x: 550, y: 150)
        
        RRButton = SKSpriteNode(imageNamed: "roundrobin-button")
        RRButton.name = "rrbutton"
        RRButton.position = CGPoint(x: 865, y: 150)
        
        for button in [STCFButton, RRButton] {
            button.setScale(0.6)
            button.texture?.filteringMode = .nearest
            button.alpha = 0
        }
        
        scene.addChild(yeahButton)
        scene.addChild(STCFButton)
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
        textSprite.run(textActionSequence)
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
                fadeOutButtons(state: state)
                scene.runFIFOSim()
                buttonPressCount += 1
            } else if nodeAtTouch.name == "stcfbutton" {
                buttonPressedAnimation(on: STCFButton)
                buttonNotPressed = RRButton
                scene.resetCustomers()
                dismissOverlay(state: state)
                fadeOutButtons(state: state)
                scene.runSTCFSim()
                buttonPressCount += 1
            } else if nodeAtTouch.name == "rrbutton" {
                buttonPressedAnimation(on: RRButton)
                buttonNotPressed = STCFButton
                scene.resetCustomers()
                fadeOutButtons(state: state)
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
        
        textSprite.run(textActionSequence)
        textBubbleSprite.run(textActionSequence)
        employeeSprite.run(actionSequence)
        background.run(backgroundActions)
    }
        
    func fadeOutButtons(state: SimState) {
        for button in [yeahButton, RRButton, STCFButton] {
            button.run(SKAction.fadeOut(withDuration: 1.0))
        }
    }
    
    mutating func showDialog(_ text: String) {
        updateText(text)
        showCommonDialogElements()
        showApppropriateButtons()
    }
    
    mutating func showFIFODialog() {
        showDialog(fifoText)
    }
    
    mutating func showSTCFDialog() {
        showDialog(stcfText)
    }
    
    mutating func showRRDialog() {
        showDialog(rrText)
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
    
    mutating func updateText(_ text: String) {
        attributedString.mutableString.setString(text)
        attributedString.setAttributes(attributes, range: NSMakeRange(0, text.count))
        textSprite.attributedText = attributedString
    }
}
