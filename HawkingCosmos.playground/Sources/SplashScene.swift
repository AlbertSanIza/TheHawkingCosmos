import SpriteKit
public class SplashSceneFile: SKScene {
    override public func sceneDidLoad() {
        super.sceneDidLoad()
    }
    override public func keyUp(with event: NSEvent) {
        goToScene()
    }
    func goToScene() {
        let mainMenuScene: SKScene = MainMenuSceneFile(fileNamed: "scenes/MainMenuScene")!
        mainMenuScene.scaleMode = .aspectFit
        view?.presentScene(mainMenuScene, transition: SKTransition.fade(withDuration: 2.0))
    }
}
