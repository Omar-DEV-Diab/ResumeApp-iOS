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
        workObject = workDetailsObject()
    }
    
    @IBAction func saveWork(_ sender: Any) {
        guard validateFields() else {
            return
        }
        workObject?.name = companyNameTextField.text!
        workObject?.duration = Float(durationTextField.text!)
        delegate?.getData(self, data: workObject!)
        dismiss(animated: true, completion: nil)
    }
    
    private func validateFields() -> Bool {
        if ((companyNameTextField.text?.isEmpty) == nil) {
            showAlert("Company name is empty")
            return false
        }
        if ((durationTextField.text?.isEmpty) == nil) {
            showAlert("Duration is empty")
            return false
        }
        return true
    }
    
    @IBAction func Cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func showAlert(_ text:String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
