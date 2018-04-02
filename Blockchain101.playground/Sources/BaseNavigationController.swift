import UIKit

public class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        navigationBar.tintColor = .white
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    }
    
}
