//
//  Utilities.swift
//  LoggitFramework
//
//  Created by Seth on 10/7/15.
//  Copyright © 2015 Seth Arnott. All rights reserved.
//

import UIKit

class Utilities: NSObject
{
    
    class func getThreadName() -> String
    {
        if NSThread.isMainThread()
        {
            return "MAIN"
        }
        
        let currentThread       = NSThread.currentThread()
        let threadDescription   = currentThread.description
        let threadAsString      = threadDescription.substringFromFirstOccuranceOfString("num = ", secondString: "}")
        
        return threadAsString!
    }
    
    class func pathForDocument(filename:String) -> String
    {
        let docsPath = self.documentsDirectoryPath() as NSString
        let filePath = docsPath.stringByAppendingPathComponent(filename)
        
        return filePath
    }
    
    class func documentsDirectoryPath() -> String
    {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        return paths[0]
    }

}
