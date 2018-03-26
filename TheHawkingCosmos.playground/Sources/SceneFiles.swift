//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class SceneFiles {
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
        default:
            sceneFile = SplashScene(fileNamed: "splashScene")!
        }
        sceneFile.scaleMode = .aspectFit
        return sceneFile
    }
}
//------------------------------------------------------------------------------------------------------------------------
