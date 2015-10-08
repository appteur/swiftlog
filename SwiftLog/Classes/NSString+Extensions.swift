//
//  NSString+Extensions.swift
//  LoggitFramework
//
//  Created by Seth on 10/7/15.
//  Copyright © 2015 Seth Arnott. All rights reserved.
//

import Foundation
import UIKit

extension String
{
    func substringFromFirstOccuranceOfString(firstString:String, secondString:String) ->String?
    {
        var returnString:String? = nil
        
        if let start:Range = self.rangeOfString(firstString)!
        {
            returnString = self.substringFromIndex(start.endIndex)
            
            if let end:Range = (returnString?.rangeOfString(secondString))!
            {
                returnString = returnString?.substringToIndex(end.startIndex)
            }
        }
        return returnString
    }
    
    func numberOfMatchesWithRegex(stringRegex:String) -> Int
    {
        do {
            let regex = try NSRegularExpression(pattern: stringRegex, options: NSRegularExpressionOptions.CaseInsensitive)
        
            let matches = regex.numberOfMatchesInString(self, options: NSMatchingOptions.ReportCompletion, range: NSMakeRange(0, self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)))
        
            return matches
        }
        catch
        {
            print(error)
            return -1
        }
    }
    
    func matchesRegexString(stringRegex:String) -> Bool
    {
        let numberOfMatches = self.numberOfMatchesWithRegex(stringRegex)
        
        return (numberOfMatches > 0) ? true : false
    }
    
    
    
    /*!
    Creates a formatted string to display time in hh:mm:ss format when given a time in seconds
    
    - parameter timeInSeconds:  Exactly what it sounds like a time in seconds (ex. 2min would be 120 seconds)
    - parameter displaySeconds: Whether the returned string should display seconds or simply hh:mm
    
    - returns: A formatted string displaying time in hh:mm:ss
    */
    static func timeStringWithTime(timeInSeconds:NSInteger, displaySeconds:Bool) -> String
    {
        let seconds     = timeInSeconds % 60
        let minutes     = (timeInSeconds / 60) % 60
        let hours       = timeInSeconds / 3600
        
        if displaySeconds
        {
            return String(format: "%02ld:%02ld:%02ld", hours, minutes, seconds)
        }
        else
        {
            return String(format: "%02ld:%02ld", hours, minutes)
        }
    }
    
    
    /*!
    Creates a two line large/small font attributed string when called on an instance of a String and passed a time interval in seconds.
    
    - parameter interval: A time interval in seconds.
    
    - returns: Returns an attributed string when called on a String object and passed a time value in seconds. It will display the time in a larger font with the text contained in "self" displaying in smaller font below the time display. If 'self' is 'In Progress' then that would be displayed below the time display
    */
    func attributedStringByAppendingFormattedTimeStringWithTime(interval:NSTimeInterval) -> NSAttributedString
    {
        let progressString = String.timeStringWithTime(Int(interval), displaySeconds: true)
        
        var attributedString:NSMutableAttributedString
        let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 17.0) as! AnyObject
        
        if self.characters.count > 0
        {
            let concatString = String(format: "%@\n%@", progressString, self)
            let thinFont     = UIFont(name: "HelveticaNeue-thin", size: 13.0) as! AnyObject
            
            attributedString = NSMutableAttributedString(string: concatString)
            
            attributedString.addAttributes([NSFontAttributeName : boldFont], range: NSMakeRange(0, progressString.characters.count))
            attributedString.addAttributes([NSFontAttributeName : thinFont], range: NSMakeRange(progressString.characters.count + 1, self.characters.count))
        }
        else
        {
            attributedString = NSMutableAttributedString(string: progressString)
            attributedString.addAttributes([NSFontAttributeName : boldFont], range: NSMakeRange(0, progressString.characters.count))
        }
        
        return attributedString
    }
    
}