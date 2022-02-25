//
//  resumeObject.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/22/22.
//

import Foundation
import UIKit

class resumeObject: NSObject, Codable {
    private(set) var ID:String!
    var mobile:String?
    var Email:String?
    var area:String?
    var careerObjective:String?
    var yearsOfExperience:String?
    var skils:[String]?
    var work:[workDetailsObject]?
    var education:[educationDetailsObject]?
    var projects:[projectDetailsObject]?
    var image:Data?
    
    override init() {
        super.init()
        self.ID = UUID().uuidString
        self.skils = [String]()
        self.work = [workDetailsObject]()
        self.education = [educationDetailsObject]()
        self.projects = [projectDetailsObject]()
    }
    
}
