//
//  SWLog.swift
//  LoggitFramework
//
//  Created by Seth on 10/7/15.
//  Copyright © 2015 Seth Arnott. All rights reserved.
//

import UIKit

public class SwiftLog
{
    static let sharedInstance = SwiftLog()
    
    var shouldLogToFile:Bool = false
    var shouldLogSynchronously:Bool = true
    
    var includeTags:Array<String>?
    var excludeTags:Array<String>?
    
    var logQueue:NSOperationQueue?
    var dateFormatter:NSDateFormatter?
    var logFileHandle:NSFileHandle?
    var semaphore:dispatch_semaphore_t?
    
    
    init()
    {
        self.includeTags = [
        
        ]
        self.excludeTags = [
        
        ]
        
        self.semaphore  = dispatch_semaphore_create(1)
        
        self.logQueue   = NSOperationQueue()
        self.logQueue?.maxConcurrentOperationCount = 1
        
        self.dateFormatter = NSDateFormatter()
        self.dateFormatter?.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        
        self.setupLogFileHandle()
    }
    
    public class func setLoggingWhitelist(list:Array<String>)
    {
        SwiftLog.sharedInstance.includeTags = list
    }
    
    public class func setLoggingBlacklist(list:Array<String>)
    {
        SwiftLog.sharedInstance.excludeTags = list
    }
    
    public class func setShouldLogToFile(flag:Bool)
    {
        SwiftLog.sharedInstance.shouldLogToFile = flag
    }
    
    public class func setShouldLogSynchronously(flag:Bool)
    {
        SwiftLog.sharedInstance.shouldLogSynchronously = flag
    }

    
    func log(tagName:String, printDate:Bool, function:String?, line:Int?, formatString:String, args:[CVarArgType])
    {
        let msg = String(format: formatString, arguments: args)
        
        let now = NSDate()
        
        
        let logClosure = {
            () -> Void in
            
            var output:String = String()
            
            if printDate
            {
                output = output+(self.dateFormatter?.stringFromDate(now))!+" "
            }
            
            // TODO: append thread name here
            let thread = Utilities.getThreadName()
            
            output = output+"[THREAD: "+thread+"] "
            
            if let function = function
            {
                output = output+"[FUNCTION: "+function+"]"
            }
        
            if line > 0
            {
                output = output+" LINE: \(line!) "
            }
            
            output = output+"["+tagName+"] "+msg
            
            if self.includeTags?.count > 0  // we have whitelist entries
            {
                var includeMatch = false
                
                for regexStr:String in self.includeTags!
                {
                    // check if our string matches any of the whitelist entries
                    if output.matchesRegexString(regexStr)
                    {
                        includeMatch = true
                        break
                    }
                }
                
                if !includeMatch
                {
                    // no matches in the whitelist so bail here
                    return
                }
            }
            
            // check if this log matches any of the blacklist
            for regexString:String in self.excludeTags!
            {
                if output.matchesRegexString(regexString)
                {
                    // this matches our blacklist so bail
                    return
                }
            }
            
            
            // log our output to the console
            print(output)
            
            // log to file if enabled
            if self.shouldLogToFile
            {
                self.writeToFile(output)
            }
            
        }   // end of logging closure
        
        if self.shouldLogSynchronously
        {
            logClosure()
        }
        else
        {
            self.logQueue?.addOperationWithBlock(logClosure)
        }
    
    }
    
    
    func writeToFile(logString:String)
    {
        let fileHandle:NSFileHandle = self.logFileHandle!
        
        fileHandle.seekToEndOfFile()
        fileHandle.writeData(logString.dataUsingEncoding(NSUTF8StringEncoding)!)
        fileHandle.synchronizeFile()
    }
    
    
    
    func setupLogFileHandle()
    {
        let logFilepath = Utilities.pathForDocument("log.txt")
        
        let fileExists = NSFileManager.defaultManager().fileExistsAtPath(logFilepath)
        
        if !fileExists
        {
            print("Log file does not exist, creating new log file at: ", logFilepath)
            
            do
            {
                try "New Log File".writeToFile(logFilepath, atomically: true, encoding: NSUTF8StringEncoding)
                
            }
            catch
            {
                print(error)
            }
        }
        
        self.logFileHandle = NSFileHandle(forUpdatingAtPath: logFilepath)
        
        do
        {
            let filelength = try NSString(contentsOfFile: logFilepath, encoding: NSUTF8StringEncoding).length
            let logString  = "Log file at [\(logFilepath)] is [\(filelength)] chars long."
            print(logString)
        }
        catch
        {
            print(error)
        }
        
    }
    

    
    
    
    
    
    
    
    
}
