//
//  StoreCellView.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit

class StoreCellView: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBOutlet weak var lbName: UILabel!
    func updateContent(store:Store) -> Void {
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
