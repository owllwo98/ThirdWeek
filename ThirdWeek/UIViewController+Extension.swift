//
//  UIViewController+Extension.swift
//  ThirdWeek
//
//  Created by 변정훈 on 1/9/25.
//

import UIKit


// 모든 UIViewController 가 다 갖고있는게 맞나?
extension UIViewController {
    
    static func CollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        // UIScreen.main.bounds.width 곧 사라짐
        // view.window?.windowScene?.screen.bounds.width
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        
        return layout
        
    }
    
}

