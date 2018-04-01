//------------------------------------------------------------------------------------------------------------------------
//
//
//    Hello Judge,
//    This is my WWDC2018 Entry...
//
//    There is just something you need to take in mind, the best size is #3.. if
//    its to small or too big you can change it below on line 37... sorry for the
//    inconvinience ❤️
//
//    Thanks,
//    Albert Sanchez
//
//
//
//
//    Instructions:
//    Click on any text.
//
//    On Fly mode:
//    W = UP
//    S = DOWN
//    A = LEFT
//    D = RIGHT
//
//    O = FORWARD
//    L = BACK
//
//
//------------------------------------------------------------------------------------------------------------------------
import SceneKit
import Foundation
import PlaygroundSupport
//------------------------------------------------------------------------------------------------------------------------
let viewSize = ViewSize()
let viewController = ViewController()
viewController.view = SCNView(frame: viewSize.option(Number: 3)) // <----- Change this number from: 1 - 4 to change size
viewController.viewDidLoad()
PlaygroundPage.current.liveView = viewController.view
//------------------------------------------------------------------------------------------------------------------------
