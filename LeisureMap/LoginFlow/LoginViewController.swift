//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate,AsyncResponseDelegate {
    
     
    @IBOutlet weak var textAccount: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var requestWorker:AsyncRequestWorker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //http://score.azurewebsites.net/api/login/acc/pwd
        //
        requestWorker = AsyncRequestWorker()
        requestWorker?.responseDelegate = self
    
        print("viewDidLoad")
    }
   
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        var account = textAccount.text!
        var password = textPassword.text!
       //
        let from:String = "https://score.azurewebsites.net/api/login/\(account)/\(password)"
        requestWorker?.getResponse(from: from, tag: 1)
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
        print(responseString)
       
//        DispatchQueue.main.async {
//            self.performSegue(withIdentifier: "moveToLoginViewSegue", sender: self)//页面切换
//        }
    }

}
