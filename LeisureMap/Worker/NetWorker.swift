//
//  NetWorker.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 miao. All rights reserved.
//

import Foundation
protocol AsyncResponseDelegate {//当得到response后下一步干啥？
    func receivedResponse(_ sender:AsyncRequestWorker,responseString:String,tag:Int)
}

class AsyncRequestWorker{
    var responseDelegate:AsyncResponseDelegate?
    func getResponse(from:String,tag:Int) -> Void {
        let url = URL(string: from)!
        let request = URLRequest(url: url)
        let config  = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            let httpResponse =  response as! HTTPURLResponse
            var statusCode = httpResponse.statusCode
            if statusCode == 200{
                let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                let responseString = String(dataString!)
                //print(responseString)
                self.responseDelegate?.receivedResponse(self, responseString: responseString, tag: tag)
            }
        }
        task.resume()
 
    }
    
}
