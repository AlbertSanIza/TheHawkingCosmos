//------------------------------------------------------------------------------------------------------------------------
import SceneKit
import Foundation
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
class ViewController: NSViewController {
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var lightNode: SCNNode!
    var wKey: Bool = false
    var sKey: Bool = false
    var aKey: Bool = false
    var dKey: Bool = false
    var spaceKey: Bool = false
    var t: CGFloat = 100.0 * CGFloat(drand48())
    var tChangeRate: CGFloat = 0.0015
    var planetsSpeed: CGFloat = 1
    let planetsInfo = [
        ["name": "sun", "size": CGFloat(800.0), "distance": CGFloat(30.0), "rotation": CGFloat(0.002), "translation": CGFloat(3.0), "planetNode": SCNNode()],
        ["name": "mercury", "size": CGFloat(50.0), "distance": CGFloat(1200.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.607), "planetNode": SCNNode()],
        ["name": "venus", "size": CGFloat(95.0), "distance": CGFloat(1450.0), "rotation": CGFloat(-0.005), "translation": CGFloat(1.174), "planetNode": SCNNode()],
        ["name": "earth", "size": CGFloat(100.0), "distance": CGFloat(1850.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.0), "planetNode": SCNNode()],
        ["name": "mars", "size": CGFloat(60.0), "distance": CGFloat(2200.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.802), "planetNode": SCNNode()],
        ["name": "jupiter", "size": CGFloat(500.0), "distance": CGFloat(2850.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.434), "planetNode": SCNNode()],
        ["name": "saturn", "size": CGFloat(400.0), "distance": CGFloat(4050.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.323), "planetNode": SCNNode()],
        ["name": "uranus", "size": CGFloat(200.0), "distance": CGFloat(5000.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.228), "planetNode": SCNNode()],
        ["name": "neptune", "size": CGFloat(180.0), "distance": CGFloat(5550.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.182), "planetNode": SCNNode()],
        ["name": "pluto", "size": CGFloat(90.0), "distance": CGFloat(5900.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.159), "planetNode": SCNNode()]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.backgroundColor = NSColor.black
        scnView.allowsCameraControl = true
        scnView.delegate = self
        scnView.isPlaying = true
        scnScene = SCNScene()
        scnView.scene = scnScene
        lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: 0, y: 0, z: 0)
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 21000
        cameraNode.position = SCNVector3(x: 0, y: 400, z: 1000)
        scnScene.rootNode.addChildNode(cameraNode)
        scnScene.rootNode.addParticleSystem(SCNParticleSystem(named: "starsParticle", inDirectory: "particles/stars/")!)
        for planet in planetsInfo {
            let ringNode = SCNNode()
            if let name: String = planet["name"] as! String?, let size: CGFloat = planet["size"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                ringNode.geometry = SCNTorus(ringRadius: distance, pipeRadius: 0.25)
                ringNode.geometry?.firstMaterial?.diffuse.contents = NSColor.systemBlue
                scnScene.rootNode.addChildNode(ringNode)
                planetNode.position = SCNVector3(x: distance, y: 0, z: 0)
                planetNode.geometry = SCNSphere(radius: size)
                planetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: name + "map")
                scnScene.rootNode.addChildNode(planetNode)
            }
        }
    }
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            if !wKey {
                wKey = true
            }
        case 1:
            if !sKey {
                sKey = true
            }
        case 0:
            if !aKey {
                aKey = true
            }
        case 2:
            if !dKey {
                dKey = true
            }
        case 49:
            if !spaceKey {
                spaceKey = true
            }
        default: break
        }
    }
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 13:
            wKey = false
        case 1:
            sKey = false
        case 0:
            aKey = false
        case 2:
            dKey = false
        case 49:
            spaceKey = false
        default: break
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
extension ViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        t += tChangeRate
        for planet in planetsInfo {
            if let distance: CGFloat = planet["distance"] as! CGFloat?, let rotation: CGFloat = planet["rotation"] as! CGFloat?, let translation: CGFloat = planet["translation"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                planetNode.position.x = distance * CGFloat(cos(t * translation * planetsSpeed))
                planetNode.position.z = distance * CGFloat(sin(t * translation * planetsSpeed))
                planetNode.eulerAngles.y += rotation
            }
        }
        if wKey {
        }
        if sKey {
        }
        if aKey {
        }
        if dKey {
        }
        if spaceKey {
        }
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
