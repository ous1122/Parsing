//
//  ViewController.swift
//  Parsing
//
//  Created by D7703_24 on 2018. 9. 17..
//  Copyright © 2018년 D7703_24. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate {
    
    var elements:[[String:String]] = []
    var item:[String:String] = [:]
    var currentElement = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
            if let myParser = XMLParser(contentsOf: path) {
                if myParser.parse() {
                    
                    
            print("Parsing Succed!")
                    print(elements)
                    
                    
        } else  {
                    
                    
                    print("Parsing Failed!") }
        
            
        } else  {
                
                
            print("parser nil")
            }
        
        
        } else {
            
            
            print("XML file not found")
       
        
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI:String?, qualifiedName qName: String?, attributes attributeDict: [String:String] = [:]) {
        currentElement = elementName
        print("currentElement = \(currentElement)")
    }
    func parser(_ parser:XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            item["name"] = data
            
        }
    }
    func parser(_ parser:XMLParser, didEndElement elementName: String, namespaceURI:String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
        }
    }
}
