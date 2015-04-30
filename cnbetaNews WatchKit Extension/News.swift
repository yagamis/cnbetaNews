//
//  News.swift
//  cnbetaNews
//
//  Created by xiaobo on 15/4/30.
//  Copyright (c) 2015年 xiaobo. All rights reserved.
//

import Foundation


class News {
    var title: String
    var time: String
    var image: String?
    
    init(dict: Dictionary<String,String>) {
        title = dict["title"]!
        time = dict["time"]!
        image = dict["image"]
    }
    
}