//
//  Event.swift
//  LiveStyleEvents
//
//  Created by Venkat Madira on 05/10/2019.
//  Copyright © 2019 Venkat Madira. All rights reserved.
//

import UIKit

class Event: Codable {
    let id: String
    let title: String
    let image: String
    let startDate: Int64
    //  let hasFav: Bool
    init( id : String,title : String,image : String,startDate : Int64) {
        self.id = id
        self.title = title
        self.image  = image
        self.startDate = startDate
        // self.hasFav = hasFav
        
    }
}
