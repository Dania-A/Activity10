//
//  APICalls.swift
//  Activity 10 Solution
//
//  Created by Dania A on 13/11/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

class APICalls {
    
    static func login (_ username : String!, _ password : String!, completion: @escaping (Bool, String, Error?)->()) {
        
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = "{\"udacity\": {\"username\": \"\(username!)\", \"password\": \"\(password!)\"}}".data(using: .utf8)
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                // TODO: Call the completion handler and send the error so it can be handled on the UI, also call "return" so the code next to this block won't be executed
            }
            
            //Get the status code to check if the response is OK or not
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                
                // TODO: Call the completion handler and send the error so it can be handled on the UI, also call "return" so the code next to this block won't be executed (you need to call return in let guard's else body anyway)
            }
            
            if statusCode >= 200  && statusCode < 300 {
                
                //Skipping the first 5 characters
                let range = Range(5..<data!.count)
                let newData = data?.subdata(in: range) /* subset response data! */
                
                //Print the data to see it and know you'll parse it (this can be removed after you complete building the app)
                print (String(data: newData!, encoding: .utf8)!)
                
                //TODO: Get an object based on the received data in JSON format
                
                //TODO: Convert the object to a dictionary and call it loginDictionary
                
                //Get the unique key of the user
                let accountDictionary = loginDictionary? ["account"] as? [String : Any]
                let uniqueKey = accountDictionary? ["key"] as? String ?? " "
                completion (true, uniqueKey, nil)
            } else {
                //TODO: call the completion handler properly
            }
        }
        //Start the task
        task.resume()
    }
    
    static func getAllLocations (completion: @escaping ([StudentLocation]?, Error?) -> ()) {
        var request = URLRequest (url: URL (string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
        
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) {data, response, error in
            if error != nil {
                // TODO: Call the completion handler and send the error so it can be handled on the UI, also call "return" so the code next to this block won't be executed
            }
            
            //Print the data to see it and know you'll parse it (this can be removed after you complete building the app)
            print (String(data: data!, encoding: .utf8)!)
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                // TODO: Call the completion handler and send the error so it can be handled on the UI, also call "return" so the code next to this block won't be executed (you need to call return in let guard's else body anyway)
            }
            
            if statusCode >= 200 && statusCode < 300 {
                
                //Get an object based on the received data in JSON format
                let jsonObject = try! JSONSerialization.jsonObject(with: data!, options: [])
                
                //TODO: Convert jsonObject to a dictionary
                
                //TODO: get the locations (associated with the key “results") and store it into a constant named resultArray
                
                //Check if the result array is nil using guard let, if it's return, otherwise continue
                guard let array = resultsArray else {return}
                
                //TODO: Convert the array above into a valid JSON Data object (so you can use that object to decode it into an array of student locations) and name it dataObject
                
                //Use JSONDecoder to convert dataObject to an array of structs
                let studentsLocations = try! JSONDecoder().decode([StudentLocation].self, from: dataObject)
                
                completion (studentsLocations, nil)
            }
        }
        
        task.resume()
    }
}
