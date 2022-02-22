//
//  ViewController.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/22/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var resumeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        resumeTableView.delegate = self
        resumeTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resumeCell", for: indexPath) as! resumeTableViewCell
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resumeView") {
           
           
            let detailVC = segue.destination as! resumeViewController
            detailVC.operation = .CREATE
           
        }
    }
}

