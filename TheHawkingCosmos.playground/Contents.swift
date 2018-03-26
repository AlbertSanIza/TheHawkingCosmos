//------------------------------------------------------------------------------------------------------------------------
import SceneKit
import SpriteKit
import Foundation
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
class ViewController: NSViewController {
    let nc = NotificationCenter.default
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var starsNode: SCNNode!
    var cameraWatch: String = ""
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var oKey: Bool = false
    var lKey: Bool = false
    var t: CGFloat = 100.0 * CGFloat(drand48())
    var planetsSpeed: CGFloat = 2
    let planetsInfo = [
        ["name": "sun", "size": CGFloat(1000.0), "distance": CGFloat(0.0), "rotation": CGFloat(0.002), "translation": CGFloat(3.0), "planetNode": SCNNode()],
        ["name": "mercury", "size": CGFloat(50.0), "distance": CGFloat(1400.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.607), "planetNode": SCNNode()],
        ["name": "venus", "size": CGFloat(95.0), "distance": CGFloat(1650.0), "rotation": CGFloat(-0.005), "translation": CGFloat(1.174), "planetNode": SCNNode()],
        ["name": "earth", "size": CGFloat(100.0), "distance": CGFloat(2050.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.0), "planetNode": SCNNode()],
        ["name": "mars", "size": CGFloat(60.0), "distance": CGFloat(2400.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.802), "planetNode": SCNNode()],
        ["name": "jupiter", "size": CGFloat(500.0), "distance": CGFloat(3050.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.434), "planetNode": SCNNode()],
        ["name": "saturn", "size": CGFloat(400.0), "distance": CGFloat(4250.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.323), "planetNode": SCNNode()],
        ["name": "uranus", "size": CGFloat(200.0), "distance": CGFloat(5200.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.228), "planetNode": SCNNode()],
        ["name": "neptune", "size": CGFloat(180.0), "distance": CGFloat(5750.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.182), "planetNode": SCNNode()],
        ["name": "pluto", "size": CGFloat(90.0), "distance": CGFloat(6100.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.159), "planetNode": SCNNode()]
    ]
    let earthMoonInfo: [String: Any?] = ["name": "earthMoon", "size": CGFloat(30.0), "distance": CGFloat(200.0), "rotation": CGFloat(0.005), "translation": CGFloat(10.0), "planetNode": SCNNode(), "ringNode": SCNNode()]
    override func viewDidLoad() {
        super.viewDidLoad()
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.backgroundColor = NSColor.black
        scnView.allowsCameraControl = false
        scnView.delegate = self
        scnView.isPlaying = true
        scnScene = SCNScene()
        scnView.scene = scnScene
        scnView.overlaySKScene = sceneFiles.init().show(Scene: "splash")
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 26000
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 18500)
        scnScene.rootNode.addChildNode(cameraNode)
        scnScene.rootNode.addParticleSystem(SCNParticleSystem(named: "starsParticle", inDirectory: "/")!)
        starsNode = SCNNode()
        starsNode.geometry = SCNSphere(radius: 12200)
        starsNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: "stars")
        starsNode.geometry?.firstMaterial?.isDoubleSided = true
        scnScene.rootNode.addChildNode(starsNode)
        for planet in planetsInfo {
            let ringNode = SCNNode()
            if let name: String = planet["name"] as! String?, let size: CGFloat = planet["size"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                let torus = SCNTorus(ringRadius: distance, pipeRadius: 1)
                torus.ringSegmentCount = 70
                ringNode.geometry = torus
                ringNode.geometry?.firstMaterial?.diffuse.contents = NSColor.systemBlue
                scnScene.rootNode.addChildNode(ringNode)
                planetNode.position = SCNVector3(x: distance, y: 0, z: 0)
                planetNode.geometry = SCNSphere(radius: size)
                planetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: name)
                if (name == "sun") {
                    planetNode.addParticleSystem(SCNParticleSystem(named: "sparksParticle", inDirectory: "/")!)
                } else if (name == "earth") {
                    if let subName: String = earthMoonInfo["name"] as! String?, let subSize: CGFloat = earthMoonInfo["size"] as! CGFloat?, let subDistance: CGFloat = earthMoonInfo["distance"] as! CGFloat?, let subPlanetNode: SCNNode = earthMoonInfo["planetNode"] as! SCNNode?, let subRingNode: SCNNode = earthMoonInfo["ringNode"] as! SCNNode? {
                        let subTorus = SCNTorus(ringRadius: subDistance, pipeRadius: 1)
                        subTorus.ringSegmentCount = 58
                        subRingNode.geometry = subTorus
                        subRingNode.geometry?.firstMaterial?.diffuse.contents = NSColor.systemBlue
                        scnScene.rootNode.addChildNode(subRingNode)
                        subPlanetNode.position = SCNVector3(x: subDistance, y: 0, z: 0)
                        subPlanetNode.geometry = SCNSphere(radius: subSize)
                        subPlanetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: subName)
                        scnScene.rootNode.addChildNode(subPlanetNode)
                    }
                }
                scnScene.rootNode.addChildNode(planetNode)
            }
        }
        nc.addObserver(self, selector: #selector(toViewControllerNotification(_:)), name: .toViewController, object: nil)
    }
    func checkOrientationAngles(rad: CGFloat) -> CGFloat {
        return rad > (2 * .pi) ? 0 : (rad < 0 ? 2 * .pi : rad)
    }
    @objc func toViewControllerNotification(_ notification: NSNotification) {
        if let boolValue: Bool = notification.userInfo?["wKey"] as? Bool {
            wKey = boolValue
        } else if let boolValue: Bool = notification.userInfo?["sKey"] as? Bool {
            sKey = boolValue
        } else if let boolValue: Bool = notification.userInfo?["aKey"] as? Bool {
            aKey = boolValue
        } else if let boolValue: Bool = notification.userInfo?["dKey"] as? Bool {
            dKey = boolValue
        } else if let boolValue: Bool = notification.userInfo?["oKey"] as? Bool {
            oKey = boolValue
        } else if let boolValue: Bool = notification.userInfo?["lKey"] as? Bool {
            lKey = boolValue
        } else if let _: Bool = notification.userInfo?["gotoSplashScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 18500), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "splash")
            }
        } else if let _: Bool = notification.userInfo?["gotoMainMenuScene"] as? Bool {
            cameraWatch = ""
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 2500, z: 11000), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "mainMenu")
            }
        } else if let _: Bool = notification.userInfo?["gotoStartScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 12000, z: -400), duration: 1), SCNAction.rotateTo(x: -(.pi / 2), y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "start")
            }
        } else if let _: Bool = notification.userInfo?["gotoInstructionsScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 1000, z: -4500), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "instructions")
            }
        } else if let _: Bool = notification.userInfo?["gotoAboutScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 950, z: 1000), duration: 1), SCNAction.rotateTo(x: 0.3, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "about")
            }
        } else if let CameraWatch: String = notification.userInfo?["cameraWatch"] as? String {
            cameraWatch = CameraWatch == "Top" ? "" : CameraWatch.lowercased()
            if (cameraWatch == "") {
                cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 12000, z: -400), duration: 1), SCNAction.rotateTo(x: -(.pi / 2), y: 0, z: 0, duration: 1)]))
            }
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
extension ViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        t += 0.0015
        starsNode.eulerAngles.y += 0.0001
        starsNode.eulerAngles.z += 0.0001
        for planet in planetsInfo {
            if let name: String = planet["name"] as! String?, let size: CGFloat = planet["size"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat?, let rotation: CGFloat = planet["rotation"] as! CGFloat?, let translation: CGFloat = planet["translation"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                planetNode.position.x = distance * cos(t * translation * planetsSpeed)
                planetNode.position.z = distance * sin(t * translation * planetsSpeed)
                planetNode.eulerAngles.y += rotation
                if (name == "earth") {
                    if let subDistance: CGFloat = earthMoonInfo["distance"] as! CGFloat?, let subRotation: CGFloat = earthMoonInfo["rotation"] as! CGFloat?, let subTranslation: CGFloat = earthMoonInfo["translation"] as! CGFloat?, let subPlanetNode: SCNNode = earthMoonInfo["planetNode"] as! SCNNode?, let subRingNode: SCNNode = earthMoonInfo["ringNode"] as! SCNNode? {
                        subRingNode.position.x = planetNode.position.x
                        subRingNode.position.z = planetNode.position.z
                        subPlanetNode.position.x = planetNode.position.x + (subDistance * cos(t * subTranslation * planetsSpeed))
                        subPlanetNode.position.z = planetNode.position.z + (subDistance * sin(t * subTranslation * planetsSpeed))
                        subPlanetNode.eulerAngles.y += subRotation
                    }
                }
                if (name == cameraWatch) {
                    cameraNode.eulerAngles.x = -.pi / 4
                    cameraNode.position.x = planetNode.position.x - ((size * 2) / 3)
                    cameraNode.position.y = planetNode.position.y + size * 2
                    cameraNode.position.z = planetNode.position.z + size * 2
                }
            }
        }
        if oKey {
            cameraNode.simdPosition += cameraNode.simdWorldFront * 10
        }
        if lKey {
            cameraNode.simdPosition -= cameraNode.simdWorldFront * 5
        }
        if wKey {
            cameraNode.eulerAngles.x = checkOrientationAngles(rad: cameraNode.eulerAngles.x + 0.004)
        }
        if sKey {
            cameraNode.eulerAngles.x = checkOrientationAngles(rad: cameraNode.eulerAngles.x - 0.004)
        }
        if aKey {
            cameraNode.eulerAngles.y = checkOrientationAngles(rad: cameraNode.eulerAngles.y + 0.01)
        }
        if dKey {
            cameraNode.eulerAngles.y = checkOrientationAngles(rad: cameraNode.eulerAngles.y - 0.01)
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class StartScene: SKScene {
    let nc = NotificationCenter.default
    var startSceneStatus: Bool = true
    var txtBack: SKLabelNode!
    var txtSun: SKLabelNode!
    var txtMercury: SKLabelNode!
    var txtVenus: SKLabelNode!
    var txtEarth: SKLabelNode!
    var txtMars: SKLabelNode!
    var txtJupiter: SKLabelNode!
    var txtSaturn: SKLabelNode!
    var txtUranus: SKLabelNode!
    var txtNeptune: SKLabelNode!
    var txtPluto: SKLabelNode!
    var txtTop: SKLabelNode!
    var nodeInfo: SKNode!
    var txtTitle: SKLabelNode!
    var txtNickname: SKLabelNode!
    var txtRadiusString: SKLabelNode!
    var txtDistanceString: SKLabelNode!
    var txtGravityString: SKLabelNode!
    var txtOrbitalString: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtBack = childNode(withName: "txtBack") as! SKLabelNode?
        txtSun = childNode(withName: "txtSun") as! SKLabelNode?
        txtMercury = childNode(withName: "txtMercury") as! SKLabelNode?
        txtVenus = childNode(withName: "txtVenus") as! SKLabelNode?
        txtEarth = childNode(withName: "txtEarth") as! SKLabelNode?
        txtMars = childNode(withName: "txtMars") as! SKLabelNode?
        txtJupiter = childNode(withName: "txtJupiter") as! SKLabelNode?
        txtSaturn = childNode(withName: "txtSaturn") as! SKLabelNode?
        txtUranus = childNode(withName: "txtUranus") as! SKLabelNode?
        txtNeptune = childNode(withName: "txtNeptune") as! SKLabelNode?
        txtPluto = childNode(withName: "txtPluto") as! SKLabelNode?
        txtTop = childNode(withName: "txtTop") as! SKLabelNode?
        nodeInfo = childNode(withName: "nodeInfo") as SKNode?
        nodeInfo.isHidden = true
        txtTitle = nodeInfo.childNode(withName: "txtTitle") as! SKLabelNode?
        txtNickname = nodeInfo.childNode(withName: "txtNickname") as! SKLabelNode?
        txtRadiusString = nodeInfo.childNode(withName: "txtRadiusString") as! SKLabelNode?
        txtDistanceString = nodeInfo.childNode(withName: "txtDistanceString") as! SKLabelNode?
        txtGravityString = nodeInfo.childNode(withName: "txtGravityString") as! SKLabelNode?
        txtOrbitalString = nodeInfo.childNode(withName: "txtOrbitalString") as! SKLabelNode?
    }
    override public func keyUp(with event: NSEvent) {
        if (startSceneStatus) {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if (startSceneStatus) {
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
            nc.post(name: .toViewController, object: nil, userInfo: ["cameraWatch": "Top"])
        default: break
        }
        nodeInfo.isHidden = withName == "txtTop"
    }
    func showInfo(Title: String, Nickname: String, Radius: String, Distance: String, Gravity: String, Orbital: String) {
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
        txtBack.removeFromParent()
        txtSun.removeFromParent()
        txtMercury.removeFromParent()
        txtVenus.removeFromParent()
        txtEarth.removeFromParent()
        txtMars.removeFromParent()
        txtJupiter.removeFromParent()
        txtSaturn.removeFromParent()
        txtUranus.removeFromParent()
        txtNeptune.removeFromParent()
        txtPluto.removeFromParent()
        txtTop.removeFromParent()
        nodeInfo.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
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
//let mainFrame = CGRect(x: 0, y: 0, width: 1024, height: 768)
//let mainFrame = CGRect(x: 0, y: 0, width: 800, height: 600)
let mainFrame = CGRect(x: 0, y: 0, width: 600, height: 450)
let viewController = ViewController()
viewController.view = SCNView(frame: mainFrame)
viewController.viewDidLoad()
PlaygroundPage.current.liveView = viewController.view
//------------------------------------------------------------------------------------------------------------------------
