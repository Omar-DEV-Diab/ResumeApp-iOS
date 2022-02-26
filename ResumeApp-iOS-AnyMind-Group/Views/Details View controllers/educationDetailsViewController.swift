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
        eduObject = educationDetailsObject()
    }
    
    @IBAction func saveEducation(_ sender: Any) {
        guard validateFields() else {
            return
        }
        eduObject?.name = classTextField.text
        eduObject?.year = yearTextField.text
        eduObject?.GPA = Float(GPATextField.text!)
        delegate?.getData(self, data: eduObject!)
        dismiss(animated: true, completion: nil)
    }
    
    private func validateFields() -> Bool {
        if ((classTextField.text?.isEmpty) == nil) {
            showAlert("Class name is empty")
            return false
        }
        if ((yearTextField.text?.isEmpty) == nil) {
            showAlert("Year is empty")
            return false
        }
        if ((GPATextField.text?.isEmpty) == nil) {
            showAlert("GPA field is empty")
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
