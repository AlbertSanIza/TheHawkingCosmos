//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class InstructionsScene: SKScene {
    let nc = NotificationCenter.default
    var instructionsSceneStatus: Bool = true
    var allNode: SKNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        allNode = childNode(withName: "allNode") as SKNode?
        if let SKSpriteNode1: SKSpriteNode = allNode.childNode(withName: "SKSpriteNode1") as! SKSpriteNode? {
            SKSpriteNode1.texture = SKTexture(imageNamed: "instructionsTwo.png")
        }
        if let SKSpriteNode2: SKSpriteNode = allNode.childNode(withName: "SKSpriteNode2") as! SKSpriteNode? {
            SKSpriteNode2.texture = SKTexture(imageNamed: "instructionsOne.png")
        }
    }
    override public func keyUp(with event: NSEvent) {
        if instructionsSceneStatus {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if instructionsSceneStatus {
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
        allNode.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
