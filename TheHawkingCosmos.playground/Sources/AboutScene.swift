//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class AboutScene: SKScene {
    let nc = NotificationCenter.default
    var aboutSceneStatus: Bool = true
    var allNode: SKNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        allNode = childNode(withName: "allNode") as SKNode?
    }
    override public func keyUp(with event: NSEvent) {
        if aboutSceneStatus {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if aboutSceneStatus {
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
        allNode.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
