//
//  NewsAPI.swift
//  cnbetaNews
//
//  Created by xiaobo on 15/4/30.
//  Copyright (c) 2015年 xiaobo. All rights reserved.
// http://cnbeta1.com/api/getArticles

import Foundation



class NewsAPI {
    
    
    //短格式的时间
    class func shortTime(timeStr:String) ->String {
        let df = NSDateFormatter()
        df.dateFormat = "yyyy/MM/dd HH:mm:ss"
        let date = df.dateFromString(timeStr)
        
        df.dateFormat = "HH:mm"
        
        return df.stringFromDate(date!)
    }
    
    class func loadNews(articleCategory:String, completion: (( [News]? ) -> Void ) ) {
        
        var query = "http://cnbeta1.com/api/"
        query += "\(articleCategory)"
        
        
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!)
        
        var task = session.dataTaskWithURL(url!, completionHandler: { (data, _, e) -> Void in
            if e != nil {
                println("网络错误")
            } else {
                
                var e: NSError?
                
                if let newsData = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &e) as? [NSDictionary] {
                    
                    let news = newsData.map{ (originItem:NSDictionary ) -> News in
                        var newItem = ["title": originItem["title"] as! String]
                        newItem["time"] = (originItem["date"] as! String)
                        newItem["image"] = (originItem["topic"] as! String)
                        
                        return News(dict: newItem)
                    }
                    
                    completion(news)
                    
                } else {
                    println(e?.localizedDescription)
                }
                
            }
        })
        task.resume()
    }
}