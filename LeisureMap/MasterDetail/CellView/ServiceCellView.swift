//
//  ServiceCellView.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit

class ServiceCellView: UICollectionViewCell {
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    func updateContent(service:ServiceCategory) -> Void {
        lbName.text = service.name
        let imageURL = service.imagePath
 
    }
}
