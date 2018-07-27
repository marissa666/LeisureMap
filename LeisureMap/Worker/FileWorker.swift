//
//  File.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 miao. All rights reserved.
//

import Foundation
protocol FileWorkerDelegate {
    func fileWorkWriteComplete(_ sender:FileWorker,fileName:String,tag:Int)
    func fileWorkReadComplete(_ sender:FileWorker,content:String,tag:Int)
}


class FileWorker {
    var fileWorkerDelegate:FileWorkerDelegate?
    func writeToFile(content:String,fileName:String,tag:Int) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(fileName)//拿到文件路径
            do{
                try content.write(to: fileURL, atomically: false, encoding: .utf8)
                self.fileWorkerDelegate?.fileWorkWriteComplete(self, fileName: fileURL.absoluteString, tag: tag)
            }catch{
                print(error)
            }
        }
    }
    
    func readFromFile(fileName:String,tag:Int)->String {
        var result:String = ""
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            let fileURL = dir.appendingPathComponent(fileName)//拿到文件路径
            do{
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                self.fileWorkerDelegate?.fileWorkReadComplete(self, content: content, tag: tag)
                result = content
            }catch{
                print(error)
            }
        
    }
        return result
   }
}
