//
//  SplashViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 miao. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController,AsyncResponseDelegate {

    var requestWorker:AsyncRequestWorker?
    var appVersion = ""
    
    @IBOutlet weak var lbVersion: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        appVersion = "" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
        lbVersion.text = appVersion
        
        //
        requestWorker = AsyncRequestWorker()
        requestWorker?.responseDelegate = self
        
        
        //
        let from:String = "https://score.azurewebsites.net/api/version/\(String(describing:appVersion))"
        requestWorker?.getResponse(from: from, tag: 1)
       
        
//        let url = URL(string: from)!
//        let request = URLRequest(url: url)
//        let config  = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//        let task = session.dataTask(with: request) { (data, response, error) in
//            let httpResponse =  response as! HTTPURLResponse
//            var statusCode = httpResponse.statusCode
//            if statusCode == 200{
//                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                let responseString = String(dataString!)
//                print(responseString)
//            }
//        }
//        task.resume()
      
       
        
    }
    
    func receivedResponse(_ sender: AsyncRequestWorker, responseString: String, tag: Int) {
        print(responseString)
        //
        let defaults = UserDefaults.standard //用于存取数据
        defaults.synchronize()
        defaults.set(responseString, forKey: "ServiceVersion")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "moveToLoginViewSegue", sender: self)//页面切换
        }
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
