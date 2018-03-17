//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
public class SplashSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        let mainMenuScene: SKScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        mainMenuScene.scaleMode = .aspectFit
        view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 2.0))
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class MainMenuSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        print(event.keyCode)
    }
    override public func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        if let touchedNode = nodes(at: mousePoint).first {
            switch touchedNode.name {
            case "txtStart"?, "txtInstructions"?, "txtAbout"?, "txtBack"?:
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                }
            default: break
            }
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
//let mainFrame = CGRect(x: 0, y: 0, width: 1024, height: 768)
let mainFrame = CGRect(x: 0, y: 0, width: 800, height: 600)
//let mainFrame = CGRect(x: 0, y: 0, width: 600, height: 450)
let mainView = SKView(frame: mainFrame)
mainView.showsFPS = true
mainView.showsNodeCount = true
mainView.showsPhysics = false
let splashScene: SKScene = SplashSceneFile(fileNamed: "scenes/SplashScene.sks")!
splashScene.scaleMode = .aspectFit
mainView.presentScene(splashScene)
PlaygroundPage.current.liveView = mainView
//------------------------------------------------------------------------------------------------------------------------
