//
//  PublicSwiftHeader.swift
//  SwiftLog
//
//  Created by Seth on 10/7/15.
//  Copyright © 2015 Seth Arnott. All rights reserved.
//

import UIKit


public func DebugLog(formatString:String, args:[CVarArgType])
{
    SwiftLog.sharedInstance.log("SWLog", printDate: true, function: #function, line: #line, formatString:formatString, args: args)
}

public func DebugLogWhereAmI()
{
    DebugLog("", args: [])
}

public func StrippedLog(formatString:String, args:[CVarArgType])
{
    SwiftLog.sharedInstance.log("SWLog", printDate: false, function: #function, line: #line, formatString:formatString, args: args)
}

public func BareLog(formatString:String, args:[CVarArgType])
{
    SwiftLog.sharedInstance.log("SWLog", printDate: false, function: nil, line: nil, formatString:formatString, args: args)
}


