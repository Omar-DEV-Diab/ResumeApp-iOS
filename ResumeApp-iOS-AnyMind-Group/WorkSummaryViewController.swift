//
//  WorkSummaryViewController.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/23/22.
//

import UIKit

class WorkSummaryViewController: UIViewController {

    var delegate: dataSentDelegate?
    var workObject: workDetailsObject?
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveWork(_ sender: Any) {
        delegate?.getData(self, data: workObject!)
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
