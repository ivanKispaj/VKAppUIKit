//
//  CustomNavigationController.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 07.04.2022.
//

import UIKit

class CastomInteractiveTransition : UIPercentDrivenInteractiveTransition {
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
}

class CustomNavigationController: UINavigationController, UINavigationControllerDelegate {

    var interactiveTransition = CastomInteractiveTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        let panEndgeGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(panRecognaiserScreen))
        panEndgeGR.edges = .left
        self.view.addGestureRecognizer(panEndgeGR)
    }
    

    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
            
        case .none:
            print("none Navigation")
            return nil
        case .push:
            return AnimationPushNavigationController()
        case .pop:
            return AnimationPopNavigationController()
        @unknown default:
            print("default navigation")
            return nil
        }
    }
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }

    @objc func panRecognaiserScreen( _ recognaiser: UIScreenEdgePanGestureRecognizer) {
       
        switch recognaiser.state {
            
        case .began:
            interactiveTransition.hasStarted = true
            self.popViewController(animated: true)
        case .changed:
            guard let width = recognaiser.view?.bounds.width else {
                interactiveTransition.hasStarted = false
                interactiveTransition.cancel()
                return
            }
            let translation = recognaiser.translation(in: recognaiser.view)
            let relativeTranslation = translation.x / width
            let progres = max(0, min(1, relativeTranslation))
            
            interactiveTransition.update(progres)
            interactiveTransition.shouldFinish = progres > 0.45
        case .ended:
            interactiveTransition.hasStarted = false
            interactiveTransition.shouldFinish ? interactiveTransition.finish() : interactiveTransition.cancel()

        case .failed:
            print("failed")
        case .cancelled:
            interactiveTransition.hasStarted = false
            interactiveTransition.cancel()
         default:
            print("Default ")
        }
    }
    

}


extension UINavigationController {
    func removeViewController(_ controller: UIViewController.Type) {
        if let viewController = viewControllers.first(where: { $0.isKind(of: controller.self) }) {
            viewController.removeFromParent()
        }
    }
}
