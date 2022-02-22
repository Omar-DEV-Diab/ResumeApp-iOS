//
//  resumeViewController.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/22/22.
//

import UIKit

enum operationType {
    case CREATE
    case EDIT
}

class resumeViewController: UIViewController {
    
    var operation:operationType?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func show(_ operator: operationType,  resume: Int) {
        //
    }
    
    func hide() {
        //
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
