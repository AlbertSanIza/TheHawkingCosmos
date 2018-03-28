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
            sceneFile = SplashScene(fileNamed: "startScene")!
        case "instructions":
            sceneFile = InstructionsScene(fileNamed: "instructionsScene")!
        case "about":
            sceneFile = AboutScene(fileNamed: "aboutScene")!
        case "fly":
            sceneFile = AboutScene(fileNamed: "flyScene")!
        default:
            sceneFile = SplashScene(fileNamed: "splashScene")!
        }
        sceneFile.scaleMode = .aspectFit
        return sceneFile
    }
}
//------------------------------------------------------------------------------------------------------------------------
