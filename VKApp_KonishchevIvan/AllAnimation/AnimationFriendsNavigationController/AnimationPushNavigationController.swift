//
//  AnimationNextNavigation.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 08.04.2022.
//

import UIKit

class AnimationPushNavigationController: NSObject, UIViewControllerAnimatedTransitioning {
    
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
        
        
        // задаем итоговое местоположение для обоих view каждого из контроллеров, оно совпадает с экраном телефона

        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
       
        // трансформируем положение экрана на который нужно перейти
 
      

        destination.view.transform = CGAffineTransform(rotationAngle: 45)
        destination.view.transform = CGAffineTransform(translationX: UIScreen.main.bounds.maxX, y: 0)
        
        // запускаем анимированное возвращение экрана в итоговое положение

        UIView.animateKeyframes(withDuration: animationDuration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                let translation = CGAffineTransform(translationX: -4500, y: -150)
                let scale = CGAffineTransform(scaleX: 0.1, y: 0.1)
                source.view.transform = translation.concatenating(scale)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.3, animations: {
                let translation = CGAffineTransform(translationX: UIScreen.main.bounds.width / 2,
                                                    y: -150)
                let rotate = CGAffineTransform(rotationAngle: 25)
                destination.view.transform = translation.concatenating(rotate)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.3, animations: {
                let translation = CGAffineTransform(translationX: 0, y: 0)
                let rotate = CGAffineTransform(rotationAngle: 0)
                destination.view.transform = translation.concatenating(rotate)
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.4, animations: {
                destination.view.transform = .identity
            })
        }) { finished in
            if finished && !transitionContext.transitionWasCancelled {
            
                source.view.transform = .identity
            }
            transitionContext.completeTransition(finished && !transitionContext.transitionWasCancelled)
        }


    }
}

