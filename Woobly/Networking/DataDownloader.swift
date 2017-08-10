//
//  DataDownloader.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import Foundation

final class DataDownloader {
    
    // only for switchoing url
    private var testValue: Int = -1
    
    var url: URL {
        testValue += 1
        switch testValue {
            case 0:
                return URL(string: "https://auja2ea4zmaoe.com/data?access_token=\(UsersProvider.accessToken ?? "")")!
            default:
                return URL(string: "https://google.com/")!
        }
    }
    
    func downloadData(completion: @escaping (Error?) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                completion(error)
            } else {
                //parse data here
                completion(nil)
            }
        }
        
        task.resume()
    }
}
