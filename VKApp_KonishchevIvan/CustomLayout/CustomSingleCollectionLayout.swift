//
//  CustomSingleCollectionLayout.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 13.03.2022.
//

import UIKit

class CustomSingleCollectionLayout: UICollectionViewLayout {

    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    // Хранит атрибуты для заданных индексов
    var columnsCount = 1 // Количество столбцов
    var cellHeight: CGFloat? = 800 // Высота ячейки
    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
    
    override func prepare() {
    self.cacheAttributes = [:] // Инициализируем атрибуты
        // Проверяем наличие collectionView
    guard let collectionView = self.collectionView else { return }
        let itemsCount = collectionView.numberOfItems(inSection: 0) // Проверяем, что в секции есть хотя бы одна ячейка
    guard itemsCount > 0 else { return }
        self.cellHeight = collectionView.frame.maxY
        let smallCellWidth = collectionView.frame.width
        
        var lastY: CGFloat = 0
        var lastX: CGFloat = 0
        for sectionsItem in 0..<collectionView.numberOfSections {
            for index in 0..<collectionView.numberOfItems(inSection: sectionsItem) {
        let indexPath = IndexPath(item: index, section: sectionsItem)
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: lastX, y: lastY, width: smallCellWidth, height: self.cellHeight!)
            let isLastColumn = (index + 2) % (self.columnsCount + 1) == 0 || index == itemsCount - 1
            if isLastColumn { lastX = 0
            lastY += self.cellHeight! } else {
            lastX += smallCellWidth }
            cacheAttributes[indexPath] = attributes
            self.totalCellsHeight += lastY
        }
            lastX = 0
        }
        
        
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cacheAttributes.values.filter { attributes in return rect.intersects(attributes.frame)
    } }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cacheAttributes[indexPath] }
    
    override var collectionViewContentSize: CGSize {
    return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellsHeight)
    }
    
}
