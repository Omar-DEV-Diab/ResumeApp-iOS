//
//  resumeTableViewCell.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/22/22.
//

import UIKit

protocol cellDelegate {
    func onEditTouched(_ resume: resumeObject)
    func onShareTouched()// maybe removed
}

class resumeTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    
    var savedResume: resumeObject?
    var delegate: cellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateCell(_ resume: resumeObject) {
        savedResume = resume
        nameLabel.text = savedResume?.ID
    }
    
    @IBAction func onClickEdit(_ sender: UIButton) {
        delegate?.onEditTouched(savedResume!)
    }
    
    @IBAction func onClickShare(_ sender: UIButton) {
        
        let pdfResumePath = shareToPdfService.shareSingelton.shareResumeAsPdf(savedResume!)
        if FileManager.default.fileExists(atPath: pdfResumePath){
            
            let url = URL(fileURLWithPath: pdfResumePath)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self
            if let rootController = UIApplication.shared.keyWindow?.rootViewController {
                var currentController: UIViewController! = rootController
                while( currentController.presentedViewController != nil ) {
                    currentController = currentController.presentedViewController
                }
                currentController.present(activityViewController, animated: true, completion: nil)
            }
        }
        else {
            print("resume was not found")
        }
    }
}
