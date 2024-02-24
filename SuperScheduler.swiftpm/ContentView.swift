import SwiftUI
import SpriteKit

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var scene = GameScene()
    
    init() {
        scene.size = CommonData.gameWindowSize
        scene.scaleMode = .aspectFit
        scene.size = CommonData.gameWindowSize
    }
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()
        }
    }
}
