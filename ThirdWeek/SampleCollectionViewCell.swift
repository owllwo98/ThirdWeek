//
//  SampleCollectionViewCell.swift
//  ThirdWeek
//
//  Created by 변정훈 on 1/9/25.
//

import UIKit

class SampleCollectionViewCell: UICollectionViewCell {
    static let identifier = "SampleCollectionViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    // 하위뷰가 추가로 실행되어야 할때
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        image.layer.cornerRadius = image.frame.width / 2
//    }
//    
//    
//    override func layoutIfNeeded() {
//        super.layoutIfNeeded()
//    }
    
    
}
