//
//  educationDetailsViewController.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/23/22.
//

import UIKit

class educationDetailsViewController: UIViewController {

    var delegate: dataSentDelegate?
    var eduObject: educationDetailsObject?
    
    @IBOutlet weak var classTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var GPATextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveEducation(_ sender: Any) {
        delegate?.getData(self, data: eduObject!)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
