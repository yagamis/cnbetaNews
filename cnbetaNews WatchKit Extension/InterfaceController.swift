//
//  InterfaceController.swift
//  cnbetaNews WatchKit Extension
//
//  Created by xiaobo on 15/4/30.
//  Copyright (c) 2015年 xiaobo. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet weak var table: WKInterfaceTable!

    //数据源
    var newsData = [News]()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        NewsAPI.loadNews("getArticles", completion: { (news) -> Void in
            if let news = news {
                self.newsData = news
                self.setupTable()
            }
        })
        
    }
    
    func setupTable() {
       var rowTypesList = [String]()
       
        for news in newsData {
            if let image = news.image {
                if image.pathExtension == "gif" {
                    rowTypesList.append("NewsRow")
                } else {
                    rowTypesList.append("ImageNewRow")
                }
            }
            
        }
        
        table.setRowTypes(rowTypesList)
        
        println(rowTypesList.count)
        
        
        
        
        //填充内容
        for index in 0..<table.numberOfRows {
            let row: AnyObject? = table.rowControllerAtIndex(index)
            let news = newsData[index]
            
            if row is ImageNewRow {
                
                let imageRow = row as! ImageNewRow
                
                let data = NSData(contentsOfURL: NSURL(string: news.image!)!)
                
                imageRow.imgNews.setImage(UIImage(data: data!))
                
                imageRow.labelNewsTitle.setText(news.title)
                imageRow.labelTime.setText(NewsAPI.shortTime(news.time))
                
                
            } else {
                
                let newsRow = row as! NewsRow
                newsRow.labelNewstitle.setText(news.title)
                newsRow.labelTime.setText(NewsAPI.shortTime(news.time))
                
            }
            
            
            
        }
        
        
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
