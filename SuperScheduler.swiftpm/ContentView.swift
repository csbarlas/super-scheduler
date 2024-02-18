import SwiftUI
import SpriteKit

struct ContentView: View {
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var scene = GameScene()
    
//    var scene: GameScene {
//        let scene = GameScene()
//        scene.size = CGSize(width: 1024, height: 768)
//        scene.scaleMode = .aspectFit
//        return scene
//    }
    
    init() {
        scene.size = Constants.gameWindowSize
        scene.scaleMode = .aspectFit
        scene.size = Constants.gameWindowSize
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
        }
    }
}
