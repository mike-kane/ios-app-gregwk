//
//  Student.swift
//  PortfolioTracker
//
//  Created by Mike Kane on 12/14/15.
//  Copyright © 2015 Mike Kane. All rights reserved.

//
import Foundation
import UIKit
import Parse

class Student: PFObject, PFSubclassing {

    var firstName: String!
    var lastName: String!
    var studentNumber: String!
    var assignments: Array<Assignment> = []
    var selectedforAssignment: Bool = false
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Student"
    }
    
    
    func saveToParse() {
        let student = PFObject(className: "Student")
        student["firstName"] = firstName
        student["lastName"] = lastName
        student["studentNumber"] = studentNumber
        student["assignments"] = assignments
        
        student.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if(success) {
                return
            } else {
                debugPrint(error?.description)
            }
        }
    }

}
    
    
    
