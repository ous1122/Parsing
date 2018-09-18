//
//  ViewController.swift
//  Parsing
//
//  Created by D7703_24 on 2018. 9. 17..
//  Copyright © 2018년 D7703_24. All rights reserved.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var strXMLData: String = ""
    var elements:[[String:String]] = []
    var item:[String:String] = [:]
    var currentElement = ""
    var weAreInItem = false    // Item tag 내에 있을때 true
    var weAreInElement = false // Element tag 내에 있을떄 true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
//        if let path = Bundle.main.url(forResource: "Fruit", withExtension: "xml") {
//            if let myParser = XMLParser(contentsOf: path) {
//               if myParser.parse() {
//
//
//            print("Parsing Succed!")
//                    print(elements)
//
//
//        } else  {
//
//
//                    print("Parsing Failed!") }
//
//
//        } else  {
//
//
//           print("parser nil")
//            }
//
//
//        } else {
//
//
//            print("XML file not found")
//
//
//        }
//    }
        myTableView.delegate = self
        myTableView.dataSource = self
        let strURL = "http://api.androidhive.info/pizza/?format=xml"
        
        if URL(string: strURL) != nil {
            if let parser = XMLParser(contentsOf: URL(string: strURL)!) {
                parser.delegate = self
                
                if parser.parse() {
                    print("parsing success")
                    print(elements)
                } else {
                    print("parsing fail")
                }
                
            }
        }
        
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI:String?, qualifiedName qName: String?, attributes attributeDict: [String:String] = [:]) {
        currentElement = elementName
        //print("********currentElement = \(currentElement)")
    }
    func parser(_ parser:XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if !data.isEmpty {
            item[currentElement] = data
            
        }
    }
    func parser(_ parser:XMLParser, didEndElement elementName: String, namespaceURI:String?, qualifiedName qName: String?) {
        if elementName == "item" {
            elements.append(item)
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return elements.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "My Cell", for: indexPath)
        let myItem = elements[indexPath.row]
        
        cell.textLabel?.text = myItem["name"]
        cell.detailTextLabel?.text = myItem["cost"]
        return cell
    }
}
//--//
