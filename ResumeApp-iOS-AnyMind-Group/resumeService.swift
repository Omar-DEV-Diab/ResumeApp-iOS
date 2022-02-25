//
//  resumeService.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/25/22.
//

import Foundation

class resumeService {
    
    static let resumeSingelton = resumeService()
    
    private let resumesKey = "resumes"
    private(set) var resumesArray:[resumeObject]
    
    init() {
        resumesArray = [resumeObject]()
        loadResumes()
    }
    
    func loadResumes() {
        if let data = UserDefaults.standard.data(forKey: resumesKey) {
            do {
                let decoder = JSONDecoder()
                resumesArray = try decoder.decode([resumeObject].self, from: data)
            } catch {
                print("Unable to Decode Notes (\(error))")
            }
        }
    }
    
    func addNewResume(_ resume: resumeObject) {
        resumesArray.append(resume)
        saveResumes()
    }
    
    func reolaceResume(_ resume: resumeObject) {
        if let row = resumesArray.firstIndex(where: {$0.ID == resume.ID}) {
            resumesArray[row] = resume
        }
        saveResumes()
    }
    
    private func saveResumes() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(resumesArray)
            UserDefaults.standard.set(data, forKey: resumesKey)
        } catch {
            print("Unable to Encode Array of Notes (\(error))")
        }
    }
}
