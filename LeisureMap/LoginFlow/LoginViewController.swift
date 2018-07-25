//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var textAccount: UITextField!
    
    @IBOutlet weak var textPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //限制长度
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       //只允许接受某些字源
        let accept = "abcdeABCDE"
        let cs = NSCharacterSet(charactersIn: accept).inverted//['a','b','c']
        print("cs")
        print(cs)
        let filtered = string.components(separatedBy: cs).joined(separator: "")//["a","b","c"]
        
        print(filtered)
        if string != filtered {
            return false
        }
        print("======")
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
