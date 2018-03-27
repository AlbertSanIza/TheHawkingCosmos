//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class SplashScene: SKScene {
    let nc = NotificationCenter.default
    var splashSceneStatus: Bool = true
    var allNode: SKNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        allNode = childNode(withName: "allNode") as SKNode?
    }
    public override func keyUp(with event: NSEvent) {
        if splashSceneStatus {
            splashSceneStatus = false
            allNode.removeFromParent()
            nc.post(name: .toViewController, object: nil, userInfo: ["gotoMainMenuScene":  true])
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
