//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class OverlayScene: SKScene {
    let nc = NotificationCenter.default
    var txtTitle: SKLabelNode!
    var txtSubTitle: SKLabelNode!
    var txtStart: SKLabelNode!
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var oKey: Bool = false
    var lKey: Bool = false
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
        txtSubTitle = childNode(withName: "txtSubTitle") as! SKLabelNode?
        txtStart = childNode(withName: "txtStart") as! SKLabelNode?
    }
    public override func keyDown(with event: NSEvent) {
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
    public override func keyUp(with event: NSEvent) {
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
        default: break
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
