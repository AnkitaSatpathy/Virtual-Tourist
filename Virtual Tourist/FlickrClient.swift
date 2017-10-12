//
//  FlickrClient.swift
//  Virtual Tourist
//
//  Created by Ankita Satpathy on 09/10/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FlickrClient: NSObject {
    
    var session: URLSession
    
    override init() {
        session = URLSession.shared
        super.init()
    }
    
    func taskForGETMethodWithParameters(_ parameters: [String:AnyObject],
                                        completionHandler: @escaping(_ result: AnyObject?, _ error: Error?) -> Void){
        let urlString = Constants.BaseURL + FlickrClient.escapedParameters(parameters)
        let request = URLRequest(url: URL(string: urlString)!)
        
        let task = session.dataTask(with: request) { (data, response, downloadError) in
            if let downloadError = downloadError {
                print("error in downloading")
                completionHandler(nil, downloadError)
            }
            else {
                FlickrClient.parseJSONWithCompletionHandler(data!, completionHandler: completionHandler)
            }
        }
    }
    
    func taskForGETMethod(_ urlString: String, completionHandler:@escaping(_ result:Data?, _ error: Error?)-> Void){
        let request = URLRequest(url: URL(string: urlString)!)
        let task = session.dataTask(with: request) { (data, response, downloadError) in
            if let downloadError = downloadError{
                print("Error in downloading")
                completionHandler(nil, downloadError)
            }
            else {
                completionHandler(data, nil)
            }
        }
    }
    
    class func substituteKeyInMethod(_ method: String, _ key: String, _ value:String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        }
        else {
            return nil
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
    
    class func escapedParameters(_ parameters: [String:AnyObject]) -> String {
        var escapedUrl = [String]()
        for (key, value) in parameters {
            if(!key.isEmpty) {
                let stringValue = "\(value)"
                let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                escapedUrl.append(key + "=" + "\(escapedValue!)")
                
            }
        }
        return escapedUrl.joined(separator: "&")
    }
    
    func showAlert(_ message:Error, _ viewController:AnyObject){
        let errorMessage = message.localizedDescription
        let alert = UIAlertController(title:nil, message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
         viewController.present(alert, animated: true, completion: nil)
    }
    
    func searchPhotosForPin(_ pin: Pin, completionHandler: @escaping (_ photoURLS: [String]?, _ error: Error?) -> Void) {
        
        let parameters: [String : AnyObject] = [
            URLKeys.Method : Methods.Search as AnyObject,
            URLKeys.APIKey : Constants.APIKey as AnyObject,
            URLKeys.Format : URLValues.JSONFormat as AnyObject,
            URLKeys.NoJSONCallback : 1 as AnyObject,
            URLKeys.Latitude : pin.latitude as AnyObject,
            URLKeys.Longitude : pin.longitude as AnyObject,
            URLKeys.Extras : URLValues.URLMediumPhoto as AnyObject,
            URLKeys.Page : "\(arc4random_uniform(10))" as AnyObject,
            URLKeys.PerPage : 10 as AnyObject
        ]
        taskForGETMethodWithParameters(parameters) { (results, error) in
            if let error = error {
                completionHandler(nil, error)
            }
            else{
                if let photosDict = results?.value(forKey:JSONResponseKeys.Photos) as? [String:AnyObject],
                    let photosArray = photosDict[JSONResponseKeys.Photo] as? [[String:AnyObject]]{
                    
                    var photoURLS = [String]()
                    
                    for photo in photosArray {
                        guard let photoURL = photo[URLValues.URLMediumPhoto] as? String else {
                            print("Error")
                            return
                        }
                        photoURLS.append(photoURL)
                        
                
                    }
                   completionHandler(photoURLS, nil)
            }
                else{
                    completionHandler(nil, error)
                }
        }
    }
}
    
    func downloadPhotos(photoURL:String, completionHandlerForDownloadPhotos: @escaping (_ image: Data?, _ error: Error?) -> Void)
    {
        let url = NSURL(string: photoURL)
        let request = URLRequest(url: url! as URL)
        
        let task = session.dataTask(with: request){ data, response, downloadError in
            
            guard let data = data else
            {
                completionHandlerForDownloadPhotos(nil,downloadError)
                return
            }
            completionHandlerForDownloadPhotos(data, nil)
        }
        task.resume()
    }
    
    class func sharedInstance() -> FlickrClient {
        struct Singleton {
            static var sharedInstance = FlickrClient()
        }
        return Singleton.sharedInstance
    }
}
