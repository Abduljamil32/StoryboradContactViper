
import Foundation

protocol HomeRoutingProtocol{
    func navigateCreateScreen()
    func navigateEditScreen(id: String)
}

class HomeRouting: HomeRoutingProtocol{
    weak var viewController: HomeViewController!
    
    func navigateCreateScreen() {
        viewController.callCreateViewController()
    }
    
    func navigateEditScreen(id: String) {
        viewController.callEditViewController(id: id)
    }
    
}
