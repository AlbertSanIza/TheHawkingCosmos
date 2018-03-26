//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class MainMenuScene: SKScene {
    let nc = NotificationCenter.default
    var mainMenuSceneStatus: Bool = true
    var txtBack: SKLabelNode!
    var txtTitle: SKLabelNode!
    var txtStart: SKLabelNode!
    var txtInstructions: SKLabelNode!
    var txtAbout: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtBack = childNode(withName: "txtBack") as! SKLabelNode?
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
        txtStart = childNode(withName: "txtStart") as! SKLabelNode?
        txtInstructions = childNode(withName: "txtInstructions") as! SKLabelNode?
        txtAbout = childNode(withName: "txtAbout") as! SKLabelNode?
    }
    override public func keyUp(with event: NSEvent) {
        if (mainMenuSceneStatus) {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if (mainMenuSceneStatus) {
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
        txtBack.removeFromParent()
        txtTitle.removeFromParent()
        txtStart.removeFromParent()
        txtInstructions.removeFromParent()
        txtAbout.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
