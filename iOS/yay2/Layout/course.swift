//
//  course.swift
//  yay2
//
//  Created by Lillian Joyce on 4/30/19.
//  Copyright © 2019 Lillian Joyce. All rights reserved.
//

import Foundation

struct Course: Codable{
    //var id: Int
    //var code: String
    //var name: String
    //var posts: String
    //var students: String
    var name: String
    var code: Int
    var instructor: String
    var enrolled: Bool
}


struct CourseDataResponse: Codable{
    var classes: [Course]
}

struct CourseResponse: Codable{
    //var success: Bool
    var data: CourseDataResponse
}

struct Student: Codable{
    
}
