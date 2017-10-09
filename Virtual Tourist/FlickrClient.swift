//
//  FlickrClient.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 09/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import Foundation
import UIKit

class FlickrClient: NSObject {
    
    var session: URLSession
    
    override init() {
        session = URLSession.shared
        super.init()
    }
    
    func taskForGETMethodWithParameters(_ parameters: [String:AnyObject],
                                        completionHandler: @escaping(_ result: AnyObject?, _ error: NSError?) -> Void){
        let urlString = ""
        let request = URLRequest(url: URL(string: urlString)!)
        
        let task = session.dataTask(with: request) { (data, response, downloadError) in
            if let error = downloadError{
                print("error in downloading")
                completionHandler(nil, error)
            }
            else {
                FlickrClient.parseJSONWithCompletionHandler(data!, completionHandler: completionHandler)
            }
        }
    }
    
    class func parseJSONWithCompletionHandler(_ data: Data, completionHandler: (_ result: AnyObject?, _ error: NSError?) -> Void) {
        
        var parsingError: NSError?
        let parsedResult: Any?
        
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        } catch let error as NSError {
            parsingError = error
            parsedResult = nil
            print("Parse error - \(parsingError!.localizedDescription)")
            return
        }
        
        if let error = parsingError {
            completionHandler(nil, error)
        } else {
            completionHandler(parsedResult as AnyObject?, nil)
        }
        
    }
    
}
