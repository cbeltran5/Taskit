//
//  Date.swift
//  TaskIt
//
//  Created by Carlos Beltran on 12/20/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import Foundation

// A date object was needed to encapsulate the process of creating an NSDate instance from a Ints, and converting 
// it to a String

class Date {

    class func from (#year: Int, month: Int, day: Int) -> NSDate {
        
        // Create an NSDateComponents objects first, to pass on to gregorianCalendar's dateFromComponents function
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        // Create the Gregorian Calendar first, then create a date by calling its function dateFromComponents
        var gregorianCalenday = NSCalendar(identifier: NSGregorianCalendar)
        var date = gregorianCalenday.dateFromComponents(components)
        
        // Need to unwrap because... it might not exist?
        return date!
    }
    
    class func toString(#date: NSDate) -> NSString {
        
        let dateStringFormatter = NSDateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = dateStringFormatter.stringFromDate(date)
        return dateString
    }
}