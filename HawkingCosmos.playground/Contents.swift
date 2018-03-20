//------------------------------------------------------------------------------------------------------------------------
import SceneKit
import SpriteKit
import Foundation
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
public class SplashSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        if let sksStars: SKSpriteNode = childNode(withName: "sksStars") as! SKSpriteNode? {
            sksStars.texture = SKTexture(imageNamed: "sprites/background/starsLayer.png")
        }
    }
    override public func keyUp(with event: NSEvent) {
        view?.presentScene(sceneFiles.init().show(Scene: "mainMenu"), transition: SKTransition.fade(withDuration: 1.0))
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class MainMenuSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        goToScene(withName: String(event.keyCode))
    }
    override public func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        if let touchedNode = nodes(at: mousePoint).first {
            switch touchedNode.name {
            case "txtStart"?, "txtInstructions"?, "txtAbout"?, "txtBack"?:
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene(withName: touchedNode.name!)
                }
            default: break
            }
        }
    }
    func goToScene(withName: String) {
        var sceneName: String = ""
        switch withName {
        case "txtStart", "1", "36":
            sceneName = "splash"
        case "txtInstructions", "34":
            sceneName = "instructions"
        case "txtAbout", "0":
            sceneName = "about"
        case "txtBack", "53", "11":
            sceneName = "splash"
        default: break
        }
        if (sceneName != "") {
            view?.presentScene(sceneFiles.init().show(Scene: sceneName), transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class InstructionsSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        goToScene(withName: String(event.keyCode))
    }
    override public func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        if let touchedNode = nodes(at: mousePoint).first {
            switch touchedNode.name {
            case "txtBack"?:
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene(withName: touchedNode.name!)
                }
            default: break
            }
        }
    }
    func goToScene(withName: String) {
        var sceneName: String = ""
        switch withName {
        case "txtBack", "53", "11":
            sceneName = "mainMenu"
        default: break
        }
        if (sceneName != "") {
            view?.presentScene(sceneFiles.init().show(Scene: sceneName), transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class AboutSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        goToScene(withName: String(event.keyCode))
    }
    override public func mouseDown(with event: NSEvent) {
        let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
        if let touchedNode = nodes(at: mousePoint).first {
            switch touchedNode.name {
            case "txtBack"?:
                touchedNode.run(SKAction.fadeOut(withDuration: 0.5)) {
                    self.goToScene(withName: touchedNode.name!)
                }
            default: break
            }
        }
    }
    func goToScene(withName: String) {
        var sceneName: String = ""
        switch withName {
        case "txtBack", "53", "11":
            sceneName = "mainMenu"
        default: break
        }
        if (sceneName != "") {
            view?.presentScene(sceneFiles.init().show(Scene: sceneName), transition: SKTransition.fade(withDuration: 1.0))
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class sceneFiles {
    public func show(Scene: String) -> SKScene {
        let sceneFile: SKScene
        switch Scene {
        case "splash":
            sceneFile = SplashSceneFile(fileNamed: "scenes/SplashScene")!
        case "mainMenu":
            sceneFile = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        case "instructions":
            sceneFile = InstructionsSceneFile(fileNamed: "scenes/InstructionsScene")!
        case "about":
            sceneFile = AboutSceneFile(fileNamed: "scenes/AboutScene")!
        default:
            sceneFile = SplashSceneFile(fileNamed: "scenes/SplashScene")!
        }
        sceneFile.scaleMode = .aspectFit
        return sceneFile
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
