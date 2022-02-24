//
//  projectsDetailsViewController.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/23/22.
//

import UIKit

class projectsDetailsViewController: UIViewController {

    var delegate: dataSentDelegate?
    var projectObject: projectDetailsObject?
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    @IBOutlet weak var summaryTextField: UITextField!
    @IBOutlet weak var techTextField: UITextField!
    @IBOutlet weak var roleTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveProject(_ sender: Any) {
        delegate?.getData(self, data: projectObject!)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
