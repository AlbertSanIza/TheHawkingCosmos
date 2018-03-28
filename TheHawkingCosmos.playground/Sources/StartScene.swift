//------------------------------------------------------------------------------------------------------------------------
import SpriteKit
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class StartScene: SKScene {
    let nc = NotificationCenter.default
    var startSceneStatus: Bool = true
    var allNode: SKNode!
    var nodeInfo: SKNode!
    var txtTitle: SKLabelNode!
    var txtNickname: SKLabelNode!
    var txtRadiusString: SKLabelNode!
    var txtDistanceString: SKLabelNode!
    var txtGravityString: SKLabelNode!
    var txtOrbitalString: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        allNode = childNode(withName: "allNode") as SKNode?
        nodeInfo = allNode.childNode(withName: "nodeInfo") as SKNode?
        nodeInfo.isHidden = true
        txtTitle = nodeInfo.childNode(withName: "txtTitle") as! SKLabelNode?
        txtNickname = nodeInfo.childNode(withName: "txtNickname") as! SKLabelNode?
        txtRadiusString = nodeInfo.childNode(withName: "txtRadiusString") as! SKLabelNode?
        txtDistanceString = nodeInfo.childNode(withName: "txtDistanceString") as! SKLabelNode?
        txtGravityString = nodeInfo.childNode(withName: "txtGravityString") as! SKLabelNode?
        txtOrbitalString = nodeInfo.childNode(withName: "txtOrbitalString") as! SKLabelNode?
    }
    override public func keyUp(with event: NSEvent) {
        if startSceneStatus {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if startSceneStatus {
            let mousePoint = convertPoint(fromView: CGPoint(x: event.locationInWindow.x, y: event.locationInWindow.y))
            if let touchedNode = nodes(at: mousePoint).first {
                goToScene(withName: touchedNode.name!)
            }
        }
    }
    func goToScene(withName: String) {
        switch withName {
        case "txtSun":
            showInfo(Title: "Sun", Nickname: "The King of the Sky", Radius: "695,700 km", Distance: "----", Gravity: "274 m/s²", Orbital: "----")
        case "txtMercury":
            showInfo(Title: "Mercury", Nickname: "Hermes", Radius: "2,440 km", Distance: "57.91 million km", Gravity: "3.7 m/s²", Orbital: "88 days")
        case "txtVenus":
            showInfo(Title: "Venus", Nickname: "The Morning Star", Radius: "6,052 km", Distance: "108.2 million km", Gravity: "8.8 m/s²", Orbital: "225 days")
        case "txtEarth":
            showInfo(Title: "Earth", Nickname: "The Blue Planet", Radius: "6,371 km", Distance: "149.6 million km", Gravity: "9.8 m/s²", Orbital: "365 days")
        case "txtMars":
            showInfo(Title: "Mars", Nickname: "The Red Planet", Radius: "3,390 km", Distance: "227.9 million km", Gravity: "3.7 m/s²", Orbital: "687 days")
        case "txtJupiter":
            showInfo(Title: "Jupiter", Nickname: "Gas Giant", Radius: "69,911 km", Distance: "778.5 million km", Gravity: "3.7 m/s²", Orbital: "12 years")
        case "txtSaturn":
            showInfo(Title: "Saturn", Nickname: "The Ringed Planet", Radius: "58,232 km", Distance: "1.429 billion km", Gravity: "24.7 m/s²", Orbital: "29 years")
        case "txtUranus":
            showInfo(Title: "Uranus", Nickname: "The Bull's Eye", Radius: "25,362 km", Distance: "2.877 billion km", Gravity: "8.6 m/s²", Orbital: "84 years")
        case "txtNeptune":
            showInfo(Title: "Neptune", Nickname: "The Last of the Gas Giants", Radius: "24,622 km", Distance: "4.498 billion km", Gravity: "11.1 m/s²", Orbital: "165 years")
        case "txtPluto":
            showInfo(Title: "Pluto", Nickname: "The Dwarf Planet", Radius: "1,186 km", Distance: "5.91 billion km", Gravity: "0.6 m/s²", Orbital: "248 years")
        case "txtTop":
            nodeInfo.isHidden = true
            nc.post(name: .toViewController, object: nil, userInfo: ["cameraWatch": "Top"])
        case "txtBack", "53", "11":
            finalRemoveAnd(goto: "gotoMainMenuScene")
        case "txtFly", "3":
            finalRemoveAnd(goto: "gotoFlyScene")
        default: break
        }
    }
    func showInfo(Title: String, Nickname: String, Radius: String, Distance: String, Gravity: String, Orbital: String) {
        nodeInfo.isHidden = false
        txtTitle.text = Title
        txtNickname.text = "\"" + Nickname + "\""
        txtRadiusString.text = Radius
        txtDistanceString.text = Distance
        txtGravityString.text = Gravity
        txtOrbitalString.text = Orbital
        nc.post(name: .toViewController, object: nil, userInfo: ["cameraWatch": Title])
    }
    func finalRemoveAnd(goto: String) {
        startSceneStatus = false
        allNode.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
//------------------------------------------------------------------------------------------------------------------------
