//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class SplashScene: SKScene {
    let nc = NotificationCenter.default
    var splashSceneStatus: Bool = true
    var txtTitle: SKLabelNode!
    var txtSubTitle: SKLabelNode!
    var txtStart: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
        txtSubTitle = childNode(withName: "txtSubTitle") as! SKLabelNode?
        txtStart = childNode(withName: "txtStart") as! SKLabelNode?
    }
    public override func keyUp(with event: NSEvent) {
        if (splashSceneStatus) {
            splashSceneStatus = false
            txtTitle.removeFromParent()
            txtSubTitle.removeFromParent()
            txtStart.removeFromParent()
            nc.post(name: .toViewController, object: nil, userInfo: ["gotoMainMenuScene":  true])
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
