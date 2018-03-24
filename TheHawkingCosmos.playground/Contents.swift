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
    var lightNode: SCNNode!
    var starsNode: SCNNode!
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
        ["name": "earthMoon", "size": CGFloat(30.0), "distance": CGFloat(200.0), "rotation": CGFloat(0.005), "translation": CGFloat(10.0), "planetNode": SCNNode()],
        ["name": "mars", "size": CGFloat(60.0), "distance": CGFloat(2400.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.802), "planetNode": SCNNode()],
        ["name": "jupiter", "size": CGFloat(500.0), "distance": CGFloat(3050.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.434), "planetNode": SCNNode()],
        ["name": "saturn", "size": CGFloat(400.0), "distance": CGFloat(4250.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.323), "planetNode": SCNNode()],
        ["name": "uranus", "size": CGFloat(200.0), "distance": CGFloat(5200.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.228), "planetNode": SCNNode()],
        ["name": "neptune", "size": CGFloat(180.0), "distance": CGFloat(5750.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.182), "planetNode": SCNNode()],
        ["name": "pluto", "size": CGFloat(90.0), "distance": CGFloat(6100.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.159), "planetNode": SCNNode()]
    ]
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
        lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 0)
//        scnScene.rootNode.addChildNode(lightNode)
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 26000
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 20000)
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
                torus.ringSegmentCount = 58
                ringNode.geometry = torus
                ringNode.geometry?.firstMaterial?.diffuse.contents = NSColor.systemBlue
                scnScene.rootNode.addChildNode(ringNode)
                planetNode.position = SCNVector3(x: distance, y: 0, z: 0)
                planetNode.geometry = SCNSphere(radius: size)
                planetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: name)
                if (name == "sun") {
                    planetNode.addParticleSystem(SCNParticleSystem(named: "sparksParticle", inDirectory: "/")!)
                }
                scnScene.rootNode.addChildNode(planetNode)
            }
        }
        nc.addObserver(self, selector: #selector(toViewControllerNotification(_:)), name: .toViewController, object: nil)
    }
    func checkOrientationAngles(rad: CGFloat) -> CGFloat {
        if (rad > (2 * .pi)) {
            return 0
        } else if (rad < 0) {
            return 2 * .pi
        }
        return rad
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
        } else if let _: Bool = notification.userInfo?["splashSceneStatus"] as? Bool {
            cameraNode.runAction(SCNAction.move(to: SCNVector3(x: 0, y: 2000, z: 11000), duration: 1)) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "splash")
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
            if let distance: CGFloat = planet["distance"] as! CGFloat?, let rotation: CGFloat = planet["rotation"] as! CGFloat?, let translation: CGFloat = planet["translation"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                planetNode.position.x = distance * cos(t * translation * planetsSpeed)
                planetNode.position.z = distance * sin(t * translation * planetsSpeed)
                planetNode.eulerAngles.y += rotation
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
public class SplashScene: SKScene {
    let nc = NotificationCenter.default
    var splashSceneStatus: Bool = true
    var txtTitle: SKLabelNode!
    var txtSubTitle: SKLabelNode!
    var txtStart: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
        txtSubTitle = childNode(withName: "txtSubTitle") as! SKLabelNode?
        txtStart = childNode(withName: "txtStart") as! SKLabelNode?
    }
    public override func keyDown(with event: NSEvent) {
        nc.post(name: .toViewController, object: nil, userInfo: ["gotoMainMenu":  false])
    }
    public override func keyUp(with event: NSEvent) {
        if (splashSceneStatus) {
            splashSceneStatus = false
            txtTitle.isHidden = true
            txtSubTitle.isHidden = true
            txtStart.isHidden = true
            nc.post(name: .toViewController, object: nil, userInfo: ["splashSceneStatus":  false])
        }
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
extension Notification.Name {
    static let toViewController = Notification.Name("toViewController")
}
//------------------------------------------------------------------------------------------------------------------------
public class sceneFiles {
    public func show(Scene: String) -> SKScene {
        let sceneFile: SKScene
        switch Scene {
        case "splash":
            sceneFile = SplashScene(fileNamed: "splashScene")!
        case "mainMenu":
            sceneFile = SplashScene(fileNamed: "mainMenuScene")!
        case "instructions":
            sceneFile = SplashScene(fileNamed: "instructionsScene")!
        case "about":
            sceneFile = SplashScene(fileNamed: "aboutScene")!
        default:
            sceneFile = SplashScene(fileNamed: "splashScene")!
        }
        sceneFile.scaleMode = .aspectFit
        return sceneFile
    }
}
//------------------------------------------------------------------------------------------------------------------------
let mainFrame = CGRect(x: 0, y: 0, width: 1024, height: 768)
//let mainFrame = CGRect(x: 0, y: 0, width: 800, height: 600)
//let mainFrame = CGRect(x: 0, y: 0, width: 600, height: 450)
let viewController = ViewController()
viewController.view = SCNView(frame: mainFrame)
viewController.viewDidLoad()
PlaygroundPage.current.liveView = viewController.view
//------------------------------------------------------------------------------------------------------------------------
