//
//  resumeTableViewCell.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/22/22.
//

import UIKit

protocol cellDelegate {
    func onEditTouched(_ resume: resumeObject)
}

class resumeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    var savedResume: resumeObject?
    var delegate: cellDelegate?

    func populateCell(_ resume: resumeObject) {
        savedResume = resume
        nameLabel.text = savedResume?.ID
    }
    
    @IBAction func onClickEdit(_ sender: UIButton) {
        delegate?.onEditTouched(savedResume!)
    }
    
    @IBAction func onClickShare(_ sender: UIButton) {
        delegate?.onShareTouched()//
        // call service better
    }
}
