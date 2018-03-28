//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class SceneFiles {
    public init() { }
    public func show(Scene: String) -> SKScene {
        let sceneFile: SKScene
        switch Scene {
        case "splash":
            sceneFile = SplashScene(fileNamed: "splashScene")!
        case "mainMenu":
            sceneFile = MainMenuScene(fileNamed: "mainMenuScene")!
        case "start":
            sceneFile = StartScene(fileNamed: "startScene")!
        case "instructions":
            sceneFile = InstructionsScene(fileNamed: "instructionsScene")!
        case "about":
            sceneFile = AboutScene(fileNamed: "aboutScene")!
        case "fly":
            sceneFile = FlyScene(fileNamed: "flyScene")!
        default:
            sceneFile = SplashScene(fileNamed: "splashScene")!
        }
        sceneFile.scaleMode = .aspectFit
        return sceneFile
    }
}
//------------------------------------------------------------------------------------------------------------------------
