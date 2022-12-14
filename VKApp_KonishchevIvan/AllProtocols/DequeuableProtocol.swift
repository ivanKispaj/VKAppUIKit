//
//  cells.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 28.05.2022.
//

import UIKit

public protocol DequeuableProtocol: AnyObject {
   
    //Возвращает имя nib-а, в котором находится ресурс.
    //Вы должны реализовать его, если ваша ячейка находится в отдельном Xib-файле.
    //Нельзя использовать в Storyboard, иначе придется использовать table.register(CellClass.self) перед использованием в коде
    //Реализация по умолчанию возвращает имя самого класса.
    static var dequeueNibName: String { get }
    
    //Это идентификатор, используемый в queue/dequeue ячейки.
    //Вам не нужно переопределять его. Реализация по умолчанию возвращает имя класса ячейки, как идентификатор.
    static var dequeueIdentifier: String { get }
}

extension DequeuableProtocol where Self: UIView {
    public static var dequeueIdentifier: String {
        return NSStringFromClass(self)
    }
    public static var dequeueNibName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
