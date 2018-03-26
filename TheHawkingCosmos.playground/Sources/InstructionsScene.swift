//------------------------------------------------------------------------------------------------------------------------
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class InstructionsScene: SKScene {
    let nc = NotificationCenter.default
    var instructionsSceneStatus: Bool = true
    var txtBack: SKLabelNode!
    var txtTitle: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtBack = childNode(withName: "txtBack") as! SKLabelNode?
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
    }
    override public func keyUp(with event: NSEvent) {
        if (instructionsSceneStatus) {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if (instructionsSceneStatus) {
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
        instructionsSceneStatus = false
        txtBack.removeFromParent()
        txtTitle.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
