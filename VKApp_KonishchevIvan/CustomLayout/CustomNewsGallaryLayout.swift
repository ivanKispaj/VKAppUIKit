//
//  CustomNewsGallaryLayout.swift
//  VKApp_KonishchevIvan
//
//  Created by Ivan Konishchev on 03.06.2022.
//


import UIKit

class CustomNewsGallaryLayout: UICollectionViewLayout {
 
    var cacheAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    // Хранит атрибуты для заданных индексов
    var columnsCount = 0 // Количество столбцов
    var cellWidth: CGFloat = UIScreen.main.bounds.width
    var cellHeight: CGFloat = 250 // Высота ячейки
    var lastY: CGFloat = 0
    private var totalCellsHeight: CGFloat = 0 // Хранит суммарную высоту всех ячеек
    
    override func prepare() {
    self.cacheAttributes = [:] // Инициализируем атрибуты
        // Проверяем наличие collectionView
    guard let collectionView = self.collectionView else { return }
        
        let sectionCount = collectionView.numberOfSections  // Количество секций
    guard  sectionCount > 0 else { return }
        for index in 0..<sectionCount {
            let rowCountInSection = collectionView.numberOfItems(inSection: index)
                setFrameInSection(section: index, rowCountInSection: rowCountInSection)
        }
        self.totalCellsHeight = self.lastY
        self.lastY = 0
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return cacheAttributes.values.filter { attributes in return rect.intersects(attributes.frame)
    } }
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cacheAttributes[indexPath] }
    
    override var collectionViewContentSize: CGSize {
    return CGSize(width: self.collectionView?.frame.width ?? 0, height: self.totalCellsHeight)
    }
    
    
    private func setFrameInSection(section: Int, rowCountInSection: Int) {
        
        let lastY: CGFloat = self.lastY
        var lastX: CGFloat = 0
        self.cellWidth = self.cellWidth / CGFloat(rowCountInSection)
        self.cellHeight = self.cellHeight / CGFloat(rowCountInSection)

        for index in 0..<rowCountInSection {
         
            let indexPath = IndexPath(item: index, section: section)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: lastX, y: lastY, width: self.cellWidth, height: self.cellHeight)
            lastX = lastX + self.cellWidth
            cacheAttributes[indexPath] = attributes
        }
        self.lastY = lastY + self.cellHeight
        self.cellWidth = UIScreen.main.bounds.width
        self.cellHeight = 250
    }
    

 
}
