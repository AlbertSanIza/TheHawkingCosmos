//------------------------------------------------------------------------------------------------------------------------
//
//
//
//
//
//------------------------------------------------------------------------------------------------------------------------
import SceneKit
import Foundation
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
let viewController = ViewController()
viewController.view = SCNView(frame: ViewSize().option(Number: 3)) // <----- Change this number from: 1 - 4 to change size
viewController.viewDidLoad()
PlaygroundPage.current.liveView = viewController.view
//------------------------------------------------------------------------------------------------------------------------
