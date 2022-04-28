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
        projectObject = projectDetailsObject()
    }
    
    @IBAction func saveProject(_ sender: Any) {
        guard validateFields() else {
            return
        }
        projectObject?.name = nameTextField.text
        projectObject?.teamSize = Int(sizeTextField.text!)
        projectObject?.summary = summaryTextField.text
        projectObject?.tech = techTextField.text
        projectObject?.role = roleTextField.text
        delegate?.getData(self, data: projectObject!)
        dismiss(animated: true, completion: nil)
    }
    
    private func validateFields() -> Bool {
        if ((nameTextField.text?.isEmpty) == nil) {
            showAlert("Project name is empty")
            return false
        }
        if ((sizeTextField.text?.isEmpty) == nil) {
            showAlert("Team size is empty")
            return false
        }
        if ((summaryTextField.text?.isEmpty) == nil) {
            showAlert("Summary field is empty")
            return false
        }
        if ((techTextField.text?.isEmpty) == nil) {
            showAlert("Tech used is empty")
            return false
        }
        if ((roleTextField.text?.isEmpty) == nil) {
            showAlert("Role is empty")
            return false
        }
        return true
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(_ text:String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
