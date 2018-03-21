//------------------------------------------------------------------------------------------------------------------------
import Cocoa
import SceneKit
import SpriteKit
import Foundation
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
//let mainFrame = CGRect(x: 0, y: 0, width: 1024, height: 768)
//let mainFrame = CGRect(x: 0, y: 0, width: 800, height: 600)
let mainFrame = CGRect(x: 0, y: 0, width: 600, height: 450)
//------------------------------------------------------------------------------------------------------------------------
class ViewController: NSViewController {
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        setupPlanets()
        setupRings()
    }
    func setupView() {
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.backgroundColor = NSColor.black
        scnView.allowsCameraControl = true
        scnView.delegate = self
        scnView.isPlaying = true
    }
    func setupScene() {
        scnScene = GameScene()
        scnView.scene = scnScene
    }
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 0)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    func setupPlanets() {
        for planet in Planets.init().info {
            let node = SCNNode()
            if let size: CGFloat = planet["size"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat? {
                node.position = SCNVector3(x: distance, y: 0, z: 0)
                node.geometry = SCNSphere(radius: size)
                node.geometry?.firstMaterial?.diffuse.contents = NSColor.white
            }
            scnScene.rootNode.addChildNode(node)
        }
    }
    func setupRings() {
        for planet in Planets.init().info {
            let node = SCNNode()
            if let distance: CGFloat = planet["distance"] as! CGFloat? {
                node.geometry = SCNTorus(ringRadius: distance, pipeRadius: 0.08)
                node.geometry?.firstMaterial?.diffuse.contents = NSColor.blue
            }
            scnScene.rootNode.addChildNode(node)
        }
    }
    override func keyUp(with event: NSEvent) {
    }
    override func keyDown(with event: NSEvent) {
    }
}
//------------------------------------------------------------------------------------------------------------------------
extension ViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
    }
}
//------------------------------------------------------------------------------------------------------------------------
class GameScene: SCNScene {
    let cameraNode: SCNNode = SCNNode()
    override init() {
        super.init()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 20000
        rootNode.addChildNode(cameraNode)
        let stars = SCNParticleSystem(named: "starsParticle", inDirectory: "particles/stars/")
        rootNode.addParticleSystem(stars!)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//------------------------------------------------------------------------------------------------------------------------
public class Planets {
    public let info = [
        ["name": "sun", "size": CGFloat(800.0), "distance": CGFloat(30.0), "rotation": 0.002, "translation": 3.0],
        ["name": "mercury", "size": CGFloat(50.0), "distance": CGFloat(1200.0), "rotation": 0.005, "translation": 1.607],
        ["name": "venus", "size": CGFloat(95.0), "distance": CGFloat(1450.0), "rotation": 0.005, "translation": 1.174],
        ["name": "earth", "size": CGFloat(100.0), "distance": CGFloat(1850.0), "rotation": 0.005, "translation": 1.0],
        ["name": "mars", "size": CGFloat(60.0), "distance": CGFloat(2200.0), "rotation": 0.005, "translation": 0.802],
        ["name": "jupiter", "size": CGFloat(500.0), "distance": CGFloat(2850.0), "rotation": 0.005, "translation": 0.434],
        ["name": "saturn", "size": CGFloat(400.0), "distance": CGFloat(4050.0), "rotation": 0.005, "translation": 0.323],
        ["name": "uranus", "size": CGFloat(200.0), "distance": CGFloat(5000.0), "rotation": 0.005, "translation": 0.228],
        ["name": "neptune", "size": CGFloat(180.0), "distance": CGFloat(5550.0), "rotation": 0.005, "translation": 0.182],
        ["name": "pluto", "size": CGFloat(90.0), "distance": CGFloat(5900.0), "rotation": 0.005, "translation": 0.159]
    ]
}
//------------------------------------------------------------------------------------------------------------------------
let viewController = ViewController()
viewController.view = SCNView(frame: mainFrame)
viewController.viewDidLoad()
PlaygroundPage.current.liveView = viewController.view
//------------------------------------------------------------------------------------------------------------------------
