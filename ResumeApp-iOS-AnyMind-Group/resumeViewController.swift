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

protocol dataSentDelegate {
    func getData(_ sender: UIViewController, data:baseDetailsObject)
}

class resumeViewController: UIViewController, dataSentDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var operation:operationType?
    var resume: resumeObject?
    var delegate: resumeDelgate?
    
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var careerObjectiveTextView: UITextView!
    @IBOutlet weak var yearsOfExperienceTextField: UITextField!
    @IBOutlet weak var skilsTextView: UITextView!
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var workStack: UIStackView!
    @IBOutlet weak var educationStack: UIStackView!
    @IBOutlet weak var projectStack: UIStackView!
    
    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        populateData()
    }
    
    private func populateData() {
        guard resume != nil else {
            resume = resumeObject()
            return
        }
        mobileTextField.text = resume?.mobile
        emailTextField.text = resume?.Email
        areaTextField.text = resume?.area
        careerObjectiveTextView.text = resume?.careerObjective
        yearsOfExperienceTextField.text = resume?.yearsOfExperience
        skilsTextView.text = resume?.getSkilsString()
        for work in resume?.work ?? [] {
            createLabelForStack(work.name!, workStack)
        }
        for edu in resume?.education ?? [] {
            createLabelForStack(edu.name!, educationStack)
        }
        for project in resume?.projects ?? [] {
            createLabelForStack(project.name!, projectStack)
        }
        photo.image = resume?.getImage()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addNewWork") {
            let workViewController = segue.destination as!  WorkSummaryViewController
            workViewController.delegate = self
        }
        if (segue.identifier == "addNewEducation") {
            let educationViewController = segue.destination as!  educationDetailsViewController
            educationViewController.delegate = self
        }
        if (segue.identifier == "addNewProject") {
            let projectViewController = segue.destination as!  projectsDetailsViewController
            projectViewController.delegate = self
        }
    }
    
    func getData(_ sender: UIViewController, data: baseDetailsObject) {
        let stack: UIStackView!
        switch sender{
        case is WorkSummaryViewController:
            stack = workStack
            resume?.work?.append(data as! workDetailsObject)
        case is educationDetailsViewController:
            stack = educationStack
            resume?.education?.append(data as! educationDetailsObject)
        case is projectsDetailsViewController:
            stack = projectStack
            resume?.projects?.append(data as! projectDetailsObject)
        default:
            return
        }
        createLabelForStack(data.name!, stack!)
    }
    
    @IBAction func saveResume(_ sender: Any) {
        guard validateFields() == true else {
            return
        }
        fillResume()
        switch operation {
        case .CREATE:
            resumeService.resumeSingelton.addNewResume(resume!)
        case .EDIT:
            resumeService.resumeSingelton.reolaceResume(resume!)
        case .none:
            return
        }
        dismiss(animated: true, completion: nil)
        delegate!.newResumeAdded()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func validateFields() -> Bool {
        if ((mobileTextField.text?.isEmpty) == nil) {
            showAlert("Mobile number is empty")
            return false
        }
        if ((emailTextField.text?.isEmpty) == nil) {
            showAlert("Email address is empty")
            return false
        }
        if ((areaTextField.text?.isEmpty) == nil) {
            showAlert("Residance area is empty")
            return false
        }
        if ((careerObjectiveTextView.text?.isEmpty) == nil) {
            showAlert("Career Objective is empty")
            return false
        }
        if ((yearsOfExperienceTextField.text?.isEmpty) == nil) {
            showAlert("Total years of experience is empty")
            return false
        }
        if (workStack.subviews.count == 0) {
            showAlert("Work summary is empty")
            return false
        }
        if ((skilsTextView.text?.isEmpty) == nil) {
            showAlert("Skills is empty")
            return false
        }
        if (educationStack.subviews.count == 0) {
            showAlert("Education is empty")
            return false
        }
        if (projectStack.subviews.count == 0) {
            showAlert("projects is empty")
            return false
        }
        if (photo.image?.cgImage == nil && photo.image?.ciImage == nil) {
            showAlert("Photo not selected")
            return false
        }
        return true
    }
    
    private func fillResume() {
        resume?.mobile = mobileTextField.text
        resume?.Email = emailTextField.text
        resume?.area = areaTextField.text
        resume?.careerObjective = careerObjectiveTextView.text
        resume?.yearsOfExperience = yearsOfExperienceTextField.text
        resume?.skils = skilsTextView.text.components(separatedBy: ",")
        resume?.image = photo.image?.pngData()
    }
    
    private func showAlert(_ text:String) {
        let alert = UIAlertController(title: "Error", message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func createLabelForStack(_ title: String, _ stack:UIStackView) {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.backgroundColor = UIColor.systemTeal
        label.text = title
        label.textColor = UIColor.white
        stack.addArrangedSubview(label)
    }
    
    @IBAction func addPhoto(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photo.contentMode = .scaleAspectFit
            photo.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

}
