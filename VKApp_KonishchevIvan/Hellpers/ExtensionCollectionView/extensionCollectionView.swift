//
//  extensionCollectionView.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 29.05.2022.
//

import UIKit


public extension UICollectionView {
    /// Зарегистрируйте ячейку из внешнего xib в экземпляр таблицы.
    ///
    /// - Parameter _: cell class
    func register<T: UICollectionViewCell>(_: T.Type) where T: DequeuableProtocol {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.dequeueNibName, bundle: bundle)
        
        self.register(nib, forCellWithReuseIdentifier: T.dequeueIdentifier)
    }
    
    /// Извлеките экземпляр ячейки, который строго типизирован.
    ///
    /// - Parameter indexPath: index path
    /// - Returns: instance
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: DequeuableProtocol {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.dequeueIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.dequeueIdentifier)")
        }
   
        return cell
    }
}
