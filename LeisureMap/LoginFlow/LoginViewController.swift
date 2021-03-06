//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController,UITextFieldDelegate,AsyncResponseDelegate,FileWorkerDelegate {
    
    @IBOutlet weak var textAccount: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var requestWorker:AsyncRequestWorker?
    var fileWorker:FileWorker?
    let storeFileName:String = "store.json"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //http://score.azurewebsites.net/api/login/acc/pwd
        //
        requestWorker = AsyncRequestWorker()
        requestWorker?.responseDelegate = self
        
        fileWorker = FileWorker()
        fileWorker?.fileWorkerDelegate = self
       
    
        print("viewDidLoad")
    }
   
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        var account = textAccount.text!
        var password = textPassword.text!
       //
        let from:String = "https://score.azurewebsites.net/api/login/\(account)/\(password)"
        requestWorker?.getResponse(from: from, tag: 1)
       
    }
    func readServiceCategory() {
        let from = "https://score.azurewebsites.net/api/servicecategory"
        requestWorker?.getResponse(from: from, tag: 2)
    }
    
    func readStore() {
        let from = "https://score.azurewebsites.net/api/store"
        requestWorker?.getResponse(from: from, tag: 3)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear")
    }
    
    //限制长度
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       //只允许接受某些字源
        let accept = "abcdeABCDE"
        let cs = NSCharacterSet(charactersIn: accept).inverted//['a','b','c']
        
        let filtered = string.components(separatedBy: cs).joined(separator: "")//["a","b","c"]
        
        print(filtered)
        if string != filtered {
            return false
        }
       
        //设置最大长度
        var maxLength:Int = 0
       
        if textField.tag == 1{
            maxLength = 4//账户最长12
        }
        if textField.tag == 2{
            maxLength = 5//密码长度最长8
        }
      
        let currentString:NSString = textField.text! as NSString
        let newString:NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        print(currentString)
        print(string)
        print(newString)
        return newString.length <= maxLength
     
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1{
            textField.resignFirstResponder()
            textPassword.becomeFirstResponder()
        }
        if textField.tag == 2{
            textPassword.resignFirstResponder()
        }
        return true
    }
    
    
    func receivedResponse(_ sender: AsyncRequestWorker, responseString: String, tag: Int) {
       // print("\(tag):\(responseString)")
        switch tag {
        case 1://login
             self.readServiceCategory()
            break
        case 2://service cateogy 通过数据库存取
            do{
                if let dataFromString = responseString.data(using: .utf8, allowLossyConversion: false) {
                    let json = try JSON(data: dataFromString)
                    //创建数据库
                    let sqliteContext = SQLiteWorker()
                    sqliteContext.createDatabase()
                    sqliteContext.clearAll()
                  
                    for (index,subJson):(String, JSON) in json {
                        // Do something you want
                        let name = subJson["name"].stringValue
                        let imagePath = subJson["imagePath"].stringValue
                        //插入数据
                        sqliteContext.insertData(_name: name, _imagepath: imagePath)
                       
                 }
//                    let categories = sqliteContext.readData()
//                    print(categories)
                }
            }catch{
                print(error)
            }
            self.readStore()
            break
        case 3://store 通过本地文件读取
            //

            
            fileWorker?.writeToFile(content: responseString, fileName:storeFileName,tag:1)
           
            break
        default:
            break
        }
        
        
        
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "moveToLoginViewSegue", sender: self)//页面切换
//        }
    }
    
    //MARK:- FileWorkerDelegate
    func fileWorkWriteComplete(_ sender: FileWorker, fileName: String, tag: Int) {
        print("write complete")
        print("\(fileName)")
        //
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moveToMasterViewSegue", sender: self)
        }
    }
    
    func fileWorkReadComplete(_ sender: FileWorker, content: String, tag: Int) {
        print("read complete")
    }
    

}
