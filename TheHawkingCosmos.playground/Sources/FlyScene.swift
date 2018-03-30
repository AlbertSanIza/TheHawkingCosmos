//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class FlyScene: SKScene {
    let nc = NotificationCenter.default
    var flySceneStatus: Bool = true
    var allNode: SKNode!
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var oKey: Bool = false
    var lKey: Bool = false
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        allNode = childNode(withName: "allNode") as SKNode?
        nc.post(name: .toViewController, object: nil, userInfo: ["playMusicFly": true])
    }
    public override func keyDown(with event: NSEvent) {
        if flySceneStatus {
            switch event.keyCode {
            case 13:
                if !wKey {
                    wKey = true
                    nc.post(name: .toViewController, object: nil, userInfo: ["wKey":  true])
                }
            case 1:
                if !sKey {
                    sKey = true
                    nc.post(name: .toViewController, object: nil, userInfo: ["sKey":  true])
                }
            case 0:
                if !aKey {
                    aKey = true
                    nc.post(name: .toViewController, object: nil, userInfo: ["aKey":  true])
                }
            case 2:
                if !dKey {
                    dKey = true
                    nc.post(name: .toViewController, object: nil, userInfo: ["dKey":  true])
                }
            case 31:
                if !oKey {
                    oKey = true
                    nc.post(name: .toViewController, object: nil, userInfo: ["oKey":  true])
                }
            case 37:
                if !lKey {
                    lKey = true
                    nc.post(name: .toViewController, object: nil, userInfo: ["lKey":  true])
                }
            default: break
            }
        }
    }
    public override func keyUp(with event: NSEvent) {
        if flySceneStatus {
            switch event.keyCode {
            case 13:
                wKey = false
                nc.post(name: .toViewController, object: nil, userInfo: ["wKey":  false])
            case 1:
                sKey = false
                nc.post(name: .toViewController, object: nil, userInfo: ["sKey":  false])
            case 0:
                aKey = false
                nc.post(name: .toViewController, object: nil, userInfo: ["aKey":  false])
            case 2:
                dKey = false
                nc.post(name: .toViewController, object: nil, userInfo: ["dKey":  false])
            case 31:
                oKey = false
                nc.post(name: .toViewController, object: nil, userInfo: ["oKey":  false])
            case 37:
                lKey = false
                nc.post(name: .toViewController, object: nil, userInfo: ["lKey":  false])
            case 53, 11:
                goToScene(withName: String(event.keyCode))
            default: break
            }
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if flySceneStatus {
            let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            if let touchedNode = nodes(at: mousePoint).first {
                goToScene(withName: touchedNode.name!)
            }
        }
    }
    func goToScene(withName: String) {
        switch withName {
        case "txtBack", "53", "11":
            finalRemoveAnd(goto: "gotoStartScene")
        default: break
        }
    }
    func finalRemoveAnd(goto: String) {
        flySceneStatus = false
        allNode.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: ["wKey":  false])
        nc.post(name: .toViewController, object: nil, userInfo: ["sKey":  false])
        nc.post(name: .toViewController, object: nil, userInfo: ["aKey":  false])
        nc.post(name: .toViewController, object: nil, userInfo: ["dKey":  false])
        nc.post(name: .toViewController, object: nil, userInfo: ["oKey":  false])
        nc.post(name: .toViewController, object: nil, userInfo: ["lKey":  false])
        nc.post(name: .toViewController, object: nil, userInfo: ["playMusicMenus": true])
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
