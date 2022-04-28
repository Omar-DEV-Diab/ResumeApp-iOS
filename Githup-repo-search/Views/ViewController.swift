//
//  ViewController.swift
//  Githup-repo-search
//
//  Created by Omar Diab on 4/28/22.
//

import UIKit

protocol resumeDelgate {
    func newResumeAdded()
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "repoCell", for: indexPath) as! resumeTableViewCell
//        cell.delegate = self
        cell.populateCell(resumes[indexPath.row])
        return cell
    }
    
    public func newResumeAdded() {
        resumeService.resumeSingelton.loadResumes()
        resumes = resumeService.resumeSingelton.resumesArray
        resumeTableView.reloadData()
    }
    
}

