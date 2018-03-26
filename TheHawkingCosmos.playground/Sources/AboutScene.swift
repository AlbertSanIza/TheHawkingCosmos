//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class AboutScene: SKScene {
    let nc = NotificationCenter.default
    var aboutSceneStatus: Bool = true
    var txtBack: SKLabelNode!
    var txtTitle: SKLabelNode!
    var txtMessage01: SKLabelNode!
    var txtMessage02: SKLabelNode!
    var txtMessage03: SKLabelNode!
    var txtMessage04: SKLabelNode!
    var txtMessage05: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtBack = childNode(withName: "txtBack") as! SKLabelNode?
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
        txtMessage01 = childNode(withName: "txtMessage01") as! SKLabelNode?
        txtMessage02 = childNode(withName: "txtMessage02") as! SKLabelNode?
        txtMessage03 = childNode(withName: "txtMessage03") as! SKLabelNode?
        txtMessage04 = childNode(withName: "txtMessage04") as! SKLabelNode?
        txtMessage05 = childNode(withName: "txtMessage05") as! SKLabelNode?
    }
    override public func keyUp(with event: NSEvent) {
        if (aboutSceneStatus) {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if (aboutSceneStatus) {
            let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            if let touchedNode = nodes(at: mousePoint).first {
                goToScene(withName: touchedNode.name!)
            }
        }
    }
    func goToScene(withName: String) {
        switch withName {
        case "txtBack", "53", "11":
            finalRemoveAnd(goto: "gotoMainMenuScene")
        default: break
        }
    }
    func finalRemoveAnd(goto: String) {
        aboutSceneStatus = false
        txtBack.removeFromParent()
        txtTitle.removeFromParent()
        txtMessage01.removeFromParent()
        txtMessage02.removeFromParent()
        txtMessage03.removeFromParent()
        txtMessage04.removeFromParent()
        txtMessage05.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
