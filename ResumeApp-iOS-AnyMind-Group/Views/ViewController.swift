//
//  ViewController.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/22/22.
//

import UIKit

protocol resumeDelgate {
    func newResumeAdded()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, cellDelegate, resumeDelgate {
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var resumeTableView: UITableView!
    
    var resumes = [resumeObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resumeTableView.delegate = self
        resumeTableView.dataSource = self
        resumeTableView.allowsSelection = false
        resumes = resumeService.resumeSingelton.resumesArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resumes.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resumeCell", for: indexPath) as! resumeTableViewCell
        cell.delegate = self
        cell.populateCell(resumes[indexPath.row])
        return cell
    }
    
    public func newResumeAdded() {
        resumeService.resumeSingelton.loadResumes()
        resumes = resumeService.resumeSingelton.resumesArray
        resumeTableView.reloadData()
    }
    
    func onEditTouched(_ resume: resumeObject) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "resumeView") as! resumeViewController
        detailVC.operation = .EDIT
        detailVC.resume = resume
        detailVC.delegate = self
        self.present(detailVC, animated: true, completion: nil)
    }
    
    func onShareTouched() {
        // later
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "create") {
            let detailVC = segue.destination as! resumeViewController
            detailVC.operation = .CREATE
            detailVC.delegate = self
        }
    }
}

