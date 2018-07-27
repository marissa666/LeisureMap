//
//  Store.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 miao. All rights reserved.
//

import Foundation
class Store{
    var serviceIndex:Int = 0
    var name:String?
    var storeLocation:LocationDesc?
    var index:Int = 0
    var imagePath:String?
}
class LocationDesc {
    var address:String?
    var latitude:Double?
    var longitude:Double?
}
