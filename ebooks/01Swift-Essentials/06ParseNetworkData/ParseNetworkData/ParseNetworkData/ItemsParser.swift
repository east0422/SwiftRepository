//
//  ResourceParser.swift
//  ParseNetworkData
//
//  Created by dfang on 2018-7-26.
//  Copyright © 2018年 east. All rights reserved.
//

import UIKit

class ItemsParser: NSObject, XMLParserDelegate {
    
    var items:[(String, String)] = []
    var inItem:Bool = false
    var inTitle:Bool = false
    var inContent:Bool = false
    
    var title:String?
    var content:String?
    
    init(data: Data) {
        super.init()
        let parser = XMLParser.init(data: data)
        parser.shouldProcessNamespaces = true
        parser.delegate = self // use self after super.init
        parser.parse()
    }
    
    // XMLParserDelegate method
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        switch elementName {  // just get title and content in item not include out
        case "item":
            inItem = true
            // <item title="title" content="content"/>
            title = attributeDict["title"]
            content = attributeDict["content"]
        case "title":
            inTitle = true
        case "content":
            inContent = true
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if inItem {
            if inTitle {
                title = string
            } else if inContent {
                content = string
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName {
        case "item":
            inItem = true
            if (title != nil && content != nil) {
                items.append((title!, content!))
                title = nil
                content = nil
            }
        case "title":
            inTitle = false
        case "content":
            inContent = false
        default:
            break
        }
    }
}
