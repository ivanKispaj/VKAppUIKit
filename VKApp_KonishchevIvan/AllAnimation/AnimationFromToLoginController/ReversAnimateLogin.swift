//
//  ReversAnimateLogin.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 06.04.2022.
//

import UIKit

class ReversAnimateLogin: NSObject, UIViewControllerAnimatedTransitioning {
   
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
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        source.view.transform = CGAffineTransform.identity
        destination.view.transform = CGAffineTransform.identity
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = source.view.frame
     //    трансформируем положение экрана на который нужно перейти
 
        destination.view.transform = CGAffineTransform(rotationAngle: 360)
   //      запускаем анимированное возвращение экрана в итоговое положение
        UIView.animate( withDuration: 1) {
            source.view.transform = CGAffineTransform(rotationAngle: 180)
            destination.view.transform = CGAffineTransform(rotationAngle: 0)
        } completion: { completion in
            transitionContext.completeTransition(completion)
            destination.view.inputViewController?.loadView()
        }
        
    

    }

    

}
