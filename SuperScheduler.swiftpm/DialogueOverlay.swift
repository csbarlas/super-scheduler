//
//  DialogueOverlay.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/16/24.
//

import Foundation
import SpriteKit

struct DialogueOverlay {
    private let scene: GameScene
    private let employeeSprite, bgSprite, textBubbleSprite, yeahButton, STCFButton, RRButton, coolButton, largeTextBubbleSprite: SKSpriteNode
    private var textLabel, largeTextLabel: SKLabelNode
    private var buttonNotPressed: SKSpriteNode!
    private var globalButtonPressCount = 0
    private var commonParagraphStyle = NSMutableParagraphStyle()
    private var font: UIFont
    private var attributes: [NSAttributedString.Key: Any]
    private var attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "")
    private let fifoText = "Serving orders in \"First In First Out\" order is easy to understand, but customers with small-sized orders wait for a long time if customers with large-sized orders are ahead! Yikes!"
    private let stcfText = "By always completing the shortest orders first, we were able to service customers with small orders even when a large order was put in first by preempting the long order! But now if a continuous stream of small orders come in, large orders never get serviced leading to starvation!"
    private let rrText = "By servicing orders in a cycle giving each customer one item of their order, we can increase the interactivity with each customer even if the wait time doesn't decrease. Customers are happy as they consistently get one item of their order and feel progress is being made!"
    private let conclusionText = "You just learned the basics of a few CPU scheduling algorithms! These algorithms are used by a special program called the scheduler that determines what other programs get to run on the CPU, for how long, in what order, etc. The ones shown today were First In First Out (FIFO), Shortest Time To Completion First (STCF), and Round Robin (RR)! I hope you were able to pick up on the strengths and weaknesses of each algorithm, but most importantly understood that not all algorithms are complex! Many solutions to Computer Science problems take inspiration from ways we approach mundane problems (like serving fast food customers) in daily life! That means anyone can be a great programmer, yourself included! Thanks for playing!"
    private let introText = "Hi! My name is Bob, and I need to work the lunch rush. I can only work on one item at a time and I want to find the best approach to serving the line of customers so they wait as little time as possible. Can you help me?"
    
    init(scene: GameScene) {
        self.scene = scene
        
        bgSprite = SKSpriteNode(color: .black, size: CommonData.gameWindowSize)
        bgSprite.position = CommonData.gameWindowCenter
        bgSprite.alpha = 0
        scene.addChild(bgSprite)
        
        employeeSprite = SKSpriteNode(imageNamed: "employee")
        employeeSprite.position = CGPoint(x: -192, y: 192)
        employeeSprite.texture?.filteringMode = .nearest
        employeeSprite.scale(to: CGSize(width: 384, height: 384))
        scene.addChild(employeeSprite)
        
        textBubbleSprite = SKSpriteNode(imageNamed: "text-bubble")
        textBubbleSprite.position = CGPoint(x: 667, y: 475)
        textBubbleSprite.texture?.filteringMode = .nearest
        textBubbleSprite.scale(to: CGSize(width: 690, height: 512))
        textBubbleSprite.alpha = 0
        scene.addChild(textBubbleSprite)
        
        largeTextBubbleSprite = SKSpriteNode(imageNamed: "final-text-bg")
        largeTextBubbleSprite.position = CommonData.gameWindowCenter
        largeTextBubbleSprite.texture?.filteringMode = .nearest
        largeTextBubbleSprite.scale(to: CGSize(width: 992, height: 992))
        largeTextBubbleSprite.alpha = 0
        scene.addChild(largeTextBubbleSprite)
        
        commonParagraphStyle =  NSMutableParagraphStyle()
        commonParagraphStyle.alignment = NSTextAlignment.center
        commonParagraphStyle.lineBreakMode = .byWordWrapping
        let cfURL = Bundle.main.url(forResource: "PublicPixel", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(cfURL, CTFontManagerScope.process, nil)
        font = UIFont(name: "PublicPixel", size: 26.0) ?? UIFont.systemFont(ofSize: 26.0)
        attributes = [
                .font : font,
                .paragraphStyle : commonParagraphStyle,
                .foregroundColor : UIColor.black
            ]
        
        attributedString.mutableString.setString(introText)
        attributedString.setAttributes(attributes, range: NSMakeRange(0, introText.count))
        textLabel = SKLabelNode(attributedText: attributedString)
        textLabel.preferredMaxLayoutWidth = 550
        textLabel.numberOfLines = 0
        textLabel.verticalAlignmentMode = .top
        textLabel.alpha = 0
        textLabel.position = CGPoint(x: 700, y: 700)
        scene.addChild(textLabel)
        
        let largeFont = font.withSize(22.0)
        let largeTitleAttr: [NSAttributedString.Key: Any] = [
            .font : largeFont,
            .paragraphStyle : commonParagraphStyle,
            .foregroundColor : UIColor.black
        ]
        
        let conclusionAttributedString = NSAttributedString(string: conclusionText, attributes: largeTitleAttr)
        largeTextLabel = SKLabelNode(attributedText: conclusionAttributedString)
        largeTextLabel.preferredMaxLayoutWidth = 900
        largeTextLabel.numberOfLines = 0
        largeTextLabel.verticalAlignmentMode = .center
        largeTextLabel.alpha = 0
        largeTextLabel.position = CommonData.gameWindowCenter
        scene.addChild(largeTextLabel)

        yeahButton = SKSpriteNode(imageNamed: "yeah-button")
        yeahButton.name = "yeahbutton"
        yeahButton.position = CGPoint(x: 700, y: 150)
        yeahButton.alpha = 0
        
        coolButton = SKSpriteNode(imageNamed: "cool-button")
        coolButton.name = "coolbutton"
        coolButton.position = CGPoint(x: 700, y: 150)
        coolButton.alpha = 0
        
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
        scene.addChild(coolButton)
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
        
        bgSprite.run(dimScreenAction)
        employeeSprite.run(actionSequence)
        textLabel.run(textActionSequence)
        textBubbleSprite.run(textActionSequence)
    }
    
    func startIntroDialog() {
        showCommonDialogElements()
        
        let textWait = SKAction.wait(forDuration: 2.5)
        let fadeInAction = SKAction.fadeIn(withDuration: 1.0)
        let textActionSequence = SKAction.sequence([textWait, fadeInAction])
        
        yeahButton.run(textActionSequence)
    }
    
    mutating func handleTouch(touch: UITouch) {
        let location = touch.location(in: scene)
        if let nodeAtTouch = self.scene.nodes(at: location).first {
            if nodeAtTouch.name == "yeahbutton" {
                buttonPressedAnimation(on: yeahButton)
                dismissOverlay()
                fadeOutButtons()
                scene.runFIFOSim()
                globalButtonPressCount += 1
            } else if nodeAtTouch.name == "stcfbutton" {
                buttonPressedAnimation(on: STCFButton)
                buttonNotPressed = RRButton
                scene.resetCustomers()
                dismissOverlay()
                fadeOutButtons()
                scene.runSTCFSim()
                globalButtonPressCount += 1
            } else if nodeAtTouch.name == "rrbutton" {
                buttonPressedAnimation(on: RRButton)
                buttonNotPressed = STCFButton
                scene.resetCustomers()
                fadeOutButtons()
                dismissOverlay()
                scene.runRRSim()
                globalButtonPressCount += 1
            } else if nodeAtTouch.name == "coolbutton" {
                buttonPressedAnimation(on: coolButton)
                fadeOutButtons()
                scene.resetCustomers()
                dismissEmployeeSprite()
                showConclusion()
                globalButtonPressCount += 1
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
    
    func dismissOverlay() {
        let brightenWait = SKAction.wait(forDuration: 2.5)
        let brightenScreen = SKAction.fadeAlpha(to: 0, duration: 1.0)
        let backgroundActions = SKAction.sequence([brightenWait, brightenScreen])
        
        dismissEmployeeSprite()
        
        bgSprite.run(backgroundActions)
    }
    
    func dismissEmployeeSprite() {
        let wait = SKAction.wait(forDuration: 1.5)
        let slideOutAction = SKAction.move(to: CGPoint(x: -192, y: 192), duration: 1.0)
        slideOutAction.timingMode = .easeInEaseOut
        let actionSequence = SKAction.sequence([wait, slideOutAction])
        
        let fadeOutAction = SKAction.fadeOut(withDuration: 1.0)
        let textActionSequence = SKAction.sequence([fadeOutAction])
        
        textLabel.run(textActionSequence)
        textBubbleSprite.run(textActionSequence)
        employeeSprite.run(actionSequence)
    }
    
    func showConclusion() {
        let wait = SKAction.wait(forDuration: 3.5)
        let actions = SKAction.sequence([wait, CommonData.standardFadeIn])
        
        largeTextBubbleSprite.run(actions)
        largeTextLabel.run(actions)
    }
        
    func fadeOutButtons() {
        for button in [yeahButton, RRButton, STCFButton, coolButton] {
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
        
        if (globalButtonPressCount == 0) {
            yeahButton.run(textActionSequence)
        } else if (globalButtonPressCount == 1) {
            RRButton.run(textActionSequence)
            STCFButton.run(textActionSequence)
        } else if (globalButtonPressCount == 2) {
            buttonNotPressed.run(textActionSequence)
        } else if (globalButtonPressCount == 3) {
            coolButton.run(textActionSequence)
        }
    }
    
    mutating func updateText(_ text: String) {
        attributedString.mutableString.setString(text)
        attributedString.setAttributes(attributes, range: NSMakeRange(0, text.count))
        textLabel.attributedText = attributedString
    }
}
