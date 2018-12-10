//
//  StudentLocation.swift
//  Activity 10 Solution
//
//  Created by Dania A on 11/11/2018.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

//Note how the properties' names in the struct are exactly equal to the keys names in the JSON response. This is necessary so we can eventually decode the response to an array of objects of this struct

struct StudentLocation : Codable {
    
    let createdAt : String?
    let firstName : String?
    let lastName : String?
    let latitude : Double?
    let longitude : Double?
    let mapString : String?
    let mediaURL : String?
    let objectId : String?
    let uniqueKey : String?
    let updatedAt : String?
    
}

