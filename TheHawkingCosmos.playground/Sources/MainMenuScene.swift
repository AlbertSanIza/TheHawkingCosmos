//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class MainMenuScene: SKScene {
    let nc = NotificationCenter.default
    var mainMenuSceneStatus: Bool = true
    var allNode: SKNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        allNode = childNode(withName: "allNode") as SKNode?
    }
    override public func keyUp(with event: NSEvent) {
        if mainMenuSceneStatus {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if mainMenuSceneStatus {
            let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            if let touchedNode = nodes(at: mousePoint).first {
                goToScene(withName: touchedNode.name!)
            }
        }
    }
    func goToScene(withName: String) {
        switch withName {
        case "txtBack", "53", "11":
            finalRemoveAnd(goto: "gotoSplashScene")
        case "txtStart", "1", "36":
            finalRemoveAnd(goto: "gotoStartScene")
        case "txtInstructions", "34":
            finalRemoveAnd(goto: "gotoInstructionsScene")
        case "txtAbout", "0":
            finalRemoveAnd(goto: "gotoAboutScene")
        default: break
        }
    }
    func finalRemoveAnd(goto: String) {
        mainMenuSceneStatus = false
        allNode.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
