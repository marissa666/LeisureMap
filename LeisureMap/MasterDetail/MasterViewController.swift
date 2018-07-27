//
//  MasterViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterViewController: UIViewController,FileWorkerDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
   

    var categories:[ServiceCategory] = []
    var stores:[Store] = []
    var displayStores:[Store] = []
    var selectedStore:Store?
    
    var fileWorker:FileWorker?
    let storeFileName:String = "store.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let sqliteContext = SQLiteWorker()
        let categoriesInSQLite = sqliteContext.readData()
        categories = categories + categoriesInSQLite
        
        //
        fileWorker = FileWorker()
        fileWorker?.fileWorkerDelegate = self
        
        //读取内容
        let content = self.fileWorker?.readFromFile(fileName: storeFileName, tag: 1)
        do{
            if let dataFromString = content?.data(using: .utf8, allowLossyConversion: false) {
                let json = try JSON(data: dataFromString)
                for (index,subJson):(String, JSON) in json {
                    let store:Store = Store()
                    
                    
                    let serviceIndex:Int = subJson["serviceIndex"].intValue
                    let index:Int = subJson["index"].intValue
                    let name:String = subJson["name"].stringValue
                    let imagePath:String = subJson["imagePath"].stringValue
                    
                    let location:JSON = subJson["location"]
                    let address = location["name"].stringValue
                    let latitude = location["latitude"].doubleValue
                    let longitude = location["longitude"].doubleValue
                    
                    store.serviceIndex = serviceIndex
                    store.name = name
                    store.index = index
                    store.imagePath = imagePath
                    
                    store.storeLocation = LocationDesc()
                    store.storeLocation?.address = address
                    store.storeLocation?.latitude = latitude
                    store.storeLocation?.longitude = longitude
                    
                    stores.append(store)
                }
            }
        }catch{
            print(error)
        }
        displayStores = displayStores + stores
        // Do any additional setup after loading the view.
    }
    
    func fileWorkWriteComplete(_ sender: FileWorker, fileName: String, tag: Int) {
        
    }
    
    func fileWorkReadComplete(_ sender: FileWorker, content: String, tag: Int) {
        
    }
    //MARK:-
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let category = categories[indexPath.row]
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCellView", for: indexPath) as! ServiceCellView
       cell.updateContent(service: category)
       return cell
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
