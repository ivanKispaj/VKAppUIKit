//
//  extensionUITableViewCellRegister.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit

public extension UITableView {
    /// Зарегистрируйте ячейку из внешнего xib в экземпляр таблицы.
    ///
    /// - Parameter _: cell class
    func register<T: UITableViewCell>(_: T.Type) where T: DequeuableProtocol {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.dequeueNibName, bundle: bundle)
        
        self.register(nib, forCellReuseIdentifier: T.dequeueIdentifier)
    }
    
    /// Извлеките экземпляр ячейки, который строго типизирован.
    ///
    /// - Parameter indexPath: index path
    /// - Returns: instance
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: DequeuableProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.dequeueIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Cannot dequeue: \(T.self) with identifier: \(T.dequeueIdentifier)")
        }
        return cell
    }
}
