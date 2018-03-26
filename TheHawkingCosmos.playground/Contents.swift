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
                torus.ringSegmentCount = 58
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
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 2500, z: 11000), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = sceneFiles.init().show(Scene: "mainMenu")
            }
        } else if let _: Bool = notification.userInfo?["gotoStartScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 11000, z: 0), duration: 1), SCNAction.rotateTo(x: -(.pi / 2), y: 0, z: 0, duration: 1)])) {
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
    public override func keyUp(with event: NSEvent) {
        if (splashSceneStatus) {
            splashSceneStatus = false
            txtTitle.removeFromParent()
            txtSubTitle.removeFromParent()
            txtStart.removeFromParent()
            nc.post(name: .toViewController, object: nil, userInfo: ["gotoMainMenuScene":  true])
        }
    }
}
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
public class StartScene: SKScene {
    let nc = NotificationCenter.default
    var startSceneStatus: Bool = true
    var txtBack: SKLabelNode!
    var txtTitle: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtBack = childNode(withName: "txtBack") as! SKLabelNode?
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
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
        default: break
        }
    }
    func finalRemoveAnd(goto: String) {
        startSceneStatus = false
        txtBack.removeFromParent()
        txtTitle.removeFromParent()
        nc.post(name: .toViewController, object: nil, userInfo: [goto: true])
    }
}
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
public class AboutScene: SKScene {
    let nc = NotificationCenter.default
    var aboutSceneStatus: Bool = true
    var txtBack: SKLabelNode!
    var txtTitle: SKLabelNode!
    var txtMessage01: SKLabelNode!
    var txtMessage02: SKLabelNode!
    var txtMessage03: SKLabelNode!
    var txtMessage04: SKLabelNode!
    var txtMessage05: SKLabelNode!
    override public func sceneDidLoad() {
        super.sceneDidLoad()
        txtBack = childNode(withName: "txtBack") as! SKLabelNode?
        txtTitle = childNode(withName: "txtTitle") as! SKLabelNode?
        txtMessage01 = childNode(withName: "txtMessage01") as! SKLabelNode?
        txtMessage02 = childNode(withName: "txtMessage02") as! SKLabelNode?
        txtMessage03 = childNode(withName: "txtMessage03") as! SKLabelNode?
        txtMessage04 = childNode(withName: "txtMessage04") as! SKLabelNode?
        txtMessage05 = childNode(withName: "txtMessage05") as! SKLabelNode?
    }
    override public func keyUp(with event: NSEvent) {
        if (aboutSceneStatus) {
            goToScene(withName: String(event.keyCode))
        }
    }
    override public func mouseDown(with event: NSEvent) {
        if (aboutSceneStatus) {
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
        txtBack.removeFromParent()
        txtTitle.removeFromParent()
        txtMessage01.removeFromParent()
        txtMessage02.removeFromParent()
        txtMessage03.removeFromParent()
        txtMessage04.removeFromParent()
        txtMessage05.removeFromParent()
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
            sceneFile = MainMenuScene(fileNamed: "mainMenuScene")!
        case "start":
            sceneFile = StartScene(fileNamed: "startScene")!
        case "instructions":
            sceneFile = InstructionsScene(fileNamed: "instructionsScene")!
        case "about":
            sceneFile = AboutScene(fileNamed: "aboutScene")!
        default:
            sceneFile = SplashScene(fileNamed: "splashScene")!
        }
        sceneFile.scaleMode = .aspectFit
        return sceneFile
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
