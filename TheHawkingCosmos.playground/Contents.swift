//------------------------------------------------------------------------------------------------------------------------
//
//
//    Hello Judge,
//
//    This is my WWDC2018 Entry...
//
//    There is just something you need to take in mind, the best size is #3.. if
//    its to small or too big you can change it below on line 22... sorry for the
//    inconvinience ❤️
//
//
//    Thanks,
//    Albert Sanchez
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
