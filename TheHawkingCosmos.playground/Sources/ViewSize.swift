//------------------------------------------------------------------------------------------------------------------------
import Foundation
//------------------------------------------------------------------------------------------------------------------------
public class ViewSize {
    public init() { }
    public func option(Number: Int) -> CGRect {
        switch Number {
        case 1:
            return CGRect(x: 0, y: 0, width: 600, height: 450)
        case 2:
            return CGRect(x: 0, y: 0, width: 800, height: 600)
        case 3:
            return CGRect(x: 0, y: 0, width: 1024, height: 768)
        case 4:
            return CGRect(x: 0, y: 0, width: 1200, height: 900)
        default:
            return CGRect(x: 0, y: 0, width: 600, height: 450)
        }
    }
}
//------------------------------------------------------------------------------------------------------------------------
