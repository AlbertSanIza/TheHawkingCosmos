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
    let planetsInfo = [
        ["name": "sun", "size": CGFloat(800.0), "distance": CGFloat(30.0), "rotation": CGFloat(0.002), "translation": CGFloat(3.0)],
        ["name": "mercury", "size": CGFloat(50.0), "distance": CGFloat(1200.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.607)],
        ["name": "venus", "size": CGFloat(95.0), "distance": CGFloat(1450.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.174)],
        ["name": "earth", "size": CGFloat(100.0), "distance": CGFloat(1850.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.0)],
        ["name": "mars", "size": CGFloat(60.0), "distance": CGFloat(2200.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.802)],
        ["name": "jupiter", "size": CGFloat(500.0), "distance": CGFloat(2850.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.434)],
        ["name": "saturn", "size": CGFloat(400.0), "distance": CGFloat(4050.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.323)],
        ["name": "uranus", "size": CGFloat(200.0), "distance": CGFloat(5000.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.228)],
        ["name": "neptune", "size": CGFloat(180.0), "distance": CGFloat(5550.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.182)],
        ["name": "pluto", "size": CGFloat(90.0), "distance": CGFloat(5900.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.159)]
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
        scnScene.rootNode.addChildNode(lightNode)
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 21000
        cameraNode.position = SCNVector3(x: 0, y: 5000, z: 0)
//        cameraNode.orientation = SCNQuaternion(x: 0.0, y: 0.0, z: 0.0, w: 0.0)
        scnScene.rootNode.addChildNode(cameraNode)
        let stars = SCNParticleSystem(named: "starsParticle", inDirectory: "particles/stars/")
        scnScene.rootNode.addParticleSystem(stars!)
        for planet in planetsInfo {
            let ringNode = SCNNode()
            let planetNode = SCNNode()
            if let name: String = planet["name"] as! String?, let size: CGFloat = planet["size"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat?, let rotation: CGFloat = planet["rotation"] as! CGFloat?, let _: CGFloat = planet["translation"] as! CGFloat? {
                ringNode.geometry = SCNTorus(ringRadius: distance, pipeRadius: 0.25)
                ringNode.geometry?.firstMaterial?.diffuse.contents = NSColor.systemBlue
                planetNode.position = SCNVector3(x: distance, y: 0, z: 0)
                planetNode.geometry = SCNSphere(radius: size)
                planetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: name + "map")
            }
            scnScene.rootNode.addChildNode(ringNode)
            scnScene.rootNode.addChildNode(planetNode)
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
extension ViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
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
