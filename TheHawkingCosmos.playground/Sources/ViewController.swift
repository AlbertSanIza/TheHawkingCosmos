//------------------------------------------------------------------------------------------------------------------------
import SceneKit
import Foundation
import AVFoundation
//------------------------------------------------------------------------------------------------------------------------
public class ViewController: NSViewController {
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
    var musicPlayer: AVAudioPlayer?
    let planetsInfo = [
        ["name": "sun", "radius": CGFloat(1000.0), "distance": CGFloat(0.0), "rotation": CGFloat(0.002), "translation": CGFloat(3.0), "planetNode": SCNNode()],
        ["name": "mercury", "radius": CGFloat(50.0), "distance": CGFloat(1400.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.607), "planetNode": SCNNode()],
        ["name": "venus", "radius": CGFloat(95.0), "distance": CGFloat(1650.0), "rotation": CGFloat(-0.005), "translation": CGFloat(1.174), "planetNode": SCNNode()],
        ["name": "earth", "radius": CGFloat(100.0), "distance": CGFloat(2050.0), "rotation": CGFloat(0.005), "translation": CGFloat(1.0), "planetNode": SCNNode()],
        ["name": "mars", "radius": CGFloat(60.0), "distance": CGFloat(2400.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.802), "planetNode": SCNNode()],
        ["name": "jupiter", "radius": CGFloat(600.0), "distance": CGFloat(3050.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.434), "planetNode": SCNNode()],
        ["name": "saturn", "radius": CGFloat(300.0), "distance": CGFloat(4350.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.323), "planetNode": SCNNode()],
        ["name": "uranus", "radius": CGFloat(200.0), "distance": CGFloat(5400.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.228), "planetNode": SCNNode()],
        ["name": "neptune", "radius": CGFloat(180.0), "distance": CGFloat(5950.0), "rotation": CGFloat(0.005), "translation": CGFloat(0.182), "planetNode": SCNNode()],
        ["name": "pluto", "radius": CGFloat(90.0), "distance": CGFloat(6300.0), "rotation": CGFloat(-0.005), "translation": CGFloat(0.159), "planetNode": SCNNode()]
    ]
    let earthMoonInfo: [String: Any?] = ["name": "earthMoon", "radius": CGFloat(30.0), "distance": CGFloat(200.0), "rotation": CGFloat(0.005), "translation": CGFloat(10.0), "planetNode": SCNNode()]
    var saturnRing: SCNNode!
    var starFighter: SCNNode!
    override public func viewDidLoad() {
        super.viewDidLoad()
        playMusic(forResource: "space", ofType: "flac")
        scnView = self.view as! SCNView
        scnView.showsStatistics = false
        scnView.backgroundColor = NSColor.black
        scnView.allowsCameraControl = false
        scnView.delegate = self
        scnView.isPlaying = true
        scnScene = SCNScene()
        scnView.scene = scnScene
        scnView.overlaySKScene = SceneFiles().show(Scene: "splash")
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .ambient
        lightNode.light?.color = NSColor(calibratedWhite: 0.4, alpha: 1.0)
        scnScene.rootNode.addChildNode(lightNode)
        let omniLightNode = SCNNode()
        omniLightNode.light = SCNLight()
        omniLightNode.light?.type = .omni
        omniLightNode.light?.color = NSColor(calibratedWhite: 1, alpha: 1.0)
        scnScene.rootNode.addChildNode(omniLightNode)
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.zFar = 26000
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 18500)
        scnScene.rootNode.addChildNode(cameraNode)
        scnScene.rootNode.addParticleSystem(SCNParticleSystem(named: "starsParticle", inDirectory: "/")!)
        SCNScene(named: "starFighter.obj")?.rootNode.enumerateChildNodes({
            (node, stop) in
            starFighter = node as SCNNode
        })
        starFighter.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: "starFighter.png")
        starFighter.position.z = 4
        starFighter.position.y = -4
        starFighter.eulerAngles.y = -(.pi / 2)
        starFighter.geometry?.firstMaterial?.diffuse.intensity = 1.5
        cameraNode.addChildNode(starFighter)
        starsNode = createSphere(name: "stars", radius: 12200, intensity: 2, doubleSided: true)
        scnScene.rootNode.addChildNode(starsNode)
        for planet in planetsInfo {
            if let name: String = planet["name"] as! String?, let radius: CGFloat = planet["radius"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                scnScene.rootNode.addChildNode(createRing(distance: distance))
                let sphere = SCNSphere(radius: radius)
                sphere.segmentCount = 80
                planetNode.geometry = sphere
                planetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: name)
                planetNode.geometry?.firstMaterial?.diffuse.intensity = 1.5
                if name == "sun" {
                    planetNode.geometry?.firstMaterial?.diffuse.intensity = 10
                    planetNode.addParticleSystem(SCNParticleSystem(named: "sparksParticle", inDirectory: "/")!)
                } else if name == "earth" {
                    if let subName: String = earthMoonInfo["name"] as! String?, let subRadius: CGFloat = earthMoonInfo["radius"] as! CGFloat?, let subDistance: CGFloat = earthMoonInfo["distance"] as! CGFloat?, let subPlanetNode: SCNNode = earthMoonInfo["planetNode"] as! SCNNode? {
                        subPlanetNode.position = SCNVector3(x: subDistance, y: 0, z: 0)
                        subPlanetNode.geometry = SCNSphere(radius: subRadius)
                        subPlanetNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: subName)
                        scnScene.rootNode.addChildNode(subPlanetNode)
                    }
                } else if name == "saturn" {
                    let loopNode = SCNNode(geometry: SCNBox(width: 1300, height: 1500, length: 0, chamferRadius: 0))
                    loopNode.geometry?.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: "saturnRing")
                    loopNode.rotation = SCNVector4(-0.5, -0.05, 0, 5)
                    planetNode.addChildNode(loopNode)
                }
                scnScene.rootNode.addChildNode(planetNode)
            }
        }
        nc.addObserver(self, selector: #selector(toViewControllerNotification(_:)), name: .toViewController, object: nil)
    }
    func createRing(distance: CGFloat) -> SCNNode {
        let torus = SCNTorus(ringRadius: distance, pipeRadius: 1)
        torus.ringSegmentCount = 100
        torus.firstMaterial?.diffuse.contents = NSColor.systemBlue
        return SCNNode(geometry: torus)
    }
    func createSphere(name: String, radius: CGFloat, intensity: CGFloat, doubleSided: Bool) -> SCNNode {
        let sphere = SCNSphere(radius: radius)
        sphere.segmentCount = 80
        sphere.firstMaterial?.diffuse.contents = NSImage(imageLiteralResourceName: name)
        sphere.firstMaterial?.diffuse.intensity = intensity
        sphere.firstMaterial?.isDoubleSided = doubleSided
        return SCNNode(geometry: sphere)
    }
    func checkOrientationAngles(rad: CGFloat) -> CGFloat {
        return rad > (2 * .pi) ? 0 : (rad < 0 ? 2 * .pi : rad)
    }
    func playMusic(forResource: String, ofType: String) {
        if let path = Bundle.main.path(forResource: forResource, ofType: ofType) {
            let filePath = NSURL(fileURLWithPath:path)
            musicPlayer = try! AVAudioPlayer.init(contentsOf: filePath as URL)
            musicPlayer?.numberOfLoops = -1
            musicPlayer?.prepareToPlay()
            musicPlayer?.volume = 0.3
            musicPlayer?.play()
        }
    }
    @objc func toViewControllerNotification(_ notification: NSNotification) {
        if let boolValue: Bool = notification.userInfo?["wKey"] as? Bool {
            wKey = boolValue
            if wKey {
                starFighter.runAction(SCNAction.moveBy(x: 0, y: -0.3, z: 0, duration: 0.2))
            } else {
                starFighter.runAction(SCNAction.moveBy(x: 0, y: 0.3, z: 0, duration: 0.5))
            }
        } else if let boolValue: Bool = notification.userInfo?["sKey"] as? Bool {
            sKey = boolValue
            if sKey {
                starFighter.runAction(SCNAction.moveBy(x: 0, y: 0.3, z: 0, duration: 0.2))
            } else {
                starFighter.runAction(SCNAction.moveBy(x: 0, y: -0.3, z: 0, duration: 0.5))
            }
        } else if let boolValue: Bool = notification.userInfo?["aKey"] as? Bool {
            aKey = boolValue
            if aKey {
                starFighter.runAction(SCNAction.rotateBy(x: 0, y: 0.2, z: 0.2, duration: 0.2))
            } else {
                starFighter.runAction(SCNAction.rotateBy(x: 0, y: -0.2, z: -0.2, duration: 0.5))
            }
        } else if let boolValue: Bool = notification.userInfo?["dKey"] as? Bool {
            dKey = boolValue
            if dKey {
                starFighter.runAction(SCNAction.rotateBy(x: 0, y: -0.2, z: -0.2, duration: 0.2))
            } else {
                starFighter.runAction(SCNAction.rotateBy(x: 0, y: 0.2, z: 0.2, duration: 0.5))
            }
        } else if let boolValue: Bool = notification.userInfo?["oKey"] as? Bool {
            oKey = boolValue
            if oKey {
                starFighter.runAction(SCNAction.moveBy(x: 0, y: 0, z: -1, duration: 0.2))
            } else {
                starFighter.runAction(SCNAction.moveBy(x: 0, y: 0, z: 1, duration: 0.2))
            }
        } else if let boolValue: Bool = notification.userInfo?["lKey"] as? Bool {
            lKey = boolValue
        } else if let _: Bool = notification.userInfo?["gotoSplashScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 0, z: 18500), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = SceneFiles().show(Scene: "splash")
            }
        } else if let _: Bool = notification.userInfo?["gotoMainMenuScene"] as? Bool {
            cameraWatch = ""
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 2500, z: 11000), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = SceneFiles().show(Scene: "mainMenu")
            }
        } else if let _: Bool = notification.userInfo?["gotoStartScene"] as? Bool {
            cameraWatch = ""
            starFighter.runAction(SCNAction.move(to: SCNVector3(x: 0, y: -4, z: 4), duration: 1))
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 12000, z: -400), duration: 1), SCNAction.rotateTo(x: -(.pi / 2), y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = SceneFiles().show(Scene: "start")
            }
        } else if let _: Bool = notification.userInfo?["gotoInstructionsScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 1100, z: -5000), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = SceneFiles().show(Scene: "instructions")
            }
        } else if let _: Bool = notification.userInfo?["gotoAboutScene"] as? Bool {
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 950, z: 1000), duration: 1), SCNAction.rotateTo(x: 0.3, y: 0, z: 0, duration: 1)])) {
                self.scnView.overlaySKScene = SceneFiles().show(Scene: "about")
            }
        } else if let _: Bool = notification.userInfo?["gotoFlyScene"] as? Bool {
            cameraWatch = ""
            cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 100, z: 5000), duration: 1), SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 1)])) {
                self.starFighter.runAction(SCNAction.move(to: SCNVector3(x: 0, y: 0, z: -4), duration: 2)) {
                    self.scnView.overlaySKScene = SceneFiles().show(Scene: "fly")
                }
            }
        } else if let CameraWatch: String = notification.userInfo?["cameraWatch"] as? String {
            cameraWatch = CameraWatch == "Top" ? "" : CameraWatch.lowercased()
            if (cameraWatch == "") {
                cameraNode.runAction(SCNAction.group([SCNAction.move(to: SCNVector3(x: 0, y: 12000, z: -400), duration: 1), SCNAction.rotateTo(x: -(.pi / 2), y: 0, z: 0, duration: 1)]))
            }
        } else if let _: Bool = notification.userInfo?["playMusicMenus"] as? Bool {
            musicPlayer?.stop()
            playMusic(forResource: "space", ofType: "flac")
        } else if let _: Bool = notification.userInfo?["playMusicFly"] as? Bool {
            musicPlayer?.stop()
            playMusic(forResource: "theDarkAmulet", ofType: "mp3")
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
extension ViewController: SCNSceneRendererDelegate {
    public func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        t += 0.0015
        starsNode.eulerAngles.y += 0.0001
        starsNode.eulerAngles.z += 0.0001
        for planet in planetsInfo {
            if let name: String = planet["name"] as! String?, let radius: CGFloat = planet["radius"] as! CGFloat?, let distance: CGFloat = planet["distance"] as! CGFloat?, let rotation: CGFloat = planet["rotation"] as! CGFloat?, let translation: CGFloat = planet["translation"] as! CGFloat?, let planetNode: SCNNode = planet["planetNode"] as! SCNNode? {
                planetNode.position.x = distance * cos(t * translation * planetsSpeed)
                planetNode.position.z = distance * sin(t * translation * planetsSpeed)
                planetNode.eulerAngles.y += rotation
                if name == "earth" {
                    if let subDistance: CGFloat = earthMoonInfo["distance"] as! CGFloat?, let subRotation: CGFloat = earthMoonInfo["rotation"] as! CGFloat?, let subTranslation: CGFloat = earthMoonInfo["translation"] as! CGFloat?, let subPlanetNode: SCNNode = earthMoonInfo["planetNode"] as! SCNNode? {
                        subPlanetNode.position.x = planetNode.position.x + (subDistance * cos(t * subTranslation * planetsSpeed))
                        subPlanetNode.position.z = planetNode.position.z + (subDistance * sin(t * subTranslation * planetsSpeed))
                        subPlanetNode.eulerAngles.y += subRotation
                    }
                }
                if name == cameraWatch {
                    cameraNode.eulerAngles.x = -.pi / 7
                    cameraNode.position.x = planetNode.position.x - ((radius * 2) / 2.5)
                    cameraNode.position.y = planetNode.position.y + radius * 1.5
                    cameraNode.position.z = planetNode.position.z + radius * 3
                }
            }
        }
        if oKey {
            cameraNode.simdPosition += cameraNode.simdWorldFront * 7
        }
        if lKey {
            cameraNode.simdPosition -= cameraNode.simdWorldFront * 4
        }
        if wKey {
            cameraNode.eulerAngles.x = checkOrientationAngles(rad: cameraNode.eulerAngles.x + 0.004)
        }
        if sKey {
            cameraNode.eulerAngles.x = checkOrientationAngles(rad: cameraNode.eulerAngles.x - 0.004)
        }
        if aKey {
            cameraNode.eulerAngles.y = checkOrientationAngles(rad: cameraNode.eulerAngles.y + 0.008)
        }
        if dKey {
            cameraNode.eulerAngles.y = checkOrientationAngles(rad: cameraNode.eulerAngles.y - 0.008)
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
