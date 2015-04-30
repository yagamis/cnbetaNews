//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"


func shortTime(timeStr:String) ->String {
    let df = NSDateFormatter()
    df.dateFormat = "yyyy/MM/dd HH:mm:ss"
    let date = df.dateFromString(timeStr)
    
    df.dateFormat = "h:mm"
    
    return df.stringFromDate(date!)
}

shortTime("2015-04-30 10:32:51")