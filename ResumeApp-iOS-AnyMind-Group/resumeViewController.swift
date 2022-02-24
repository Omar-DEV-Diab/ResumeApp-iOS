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

class resumeViewController: UIViewController, dataSentDelegate {
    
    var operation:operationType?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        case is educationDetailsViewController:
            stack = educationStack
        case is projectsDetailsViewController:
            stack = projectStack
        default:
            stack = projectStack
        }
        createLabelForStack(data.name!, stack!)
    }
    
    @IBAction func saveResume(_ sender: Any) {
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


    func createLabelForStack(_ title: String, _ stack:UIStackView) {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        label.backgroundColor = UIColor.blue
        label.text = title
        label.textColor = UIColor.white
        stack.addArrangedSubview(label)
    }
    }

}
