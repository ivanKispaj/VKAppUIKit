//
//  AnimateGallaryPop.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 10.04.2022.
//

import UIKit

class AnimateGallaryPop: NSObject, UIViewControllerAnimatedTransitioning {
   
    private let animationDuration: TimeInterval = 2
   
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Получаем оба view controller'a
        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) else { return }
        
        // Добавляем destination в контейнер
        transitionContext.containerView.addSubview(destination.view)
       
        
//         задаем итоговое местоположение для обоих view каждого из контроллеров, оно совпадает с экраном телефона
      
 
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame       
        destination.view.layer.opacity = 0
        
        
        // запускаем анимированное возвращение экрана в итоговое положение
        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
                source.view.layer.opacity = 0
                
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
                destination.view.layer.opacity = 1
            })

            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 1, animations: {
                destination.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
                        source.removeFromParent()
            } else if transitionContext.transitionWasCancelled {
                destination.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
            
        }
    }
}
