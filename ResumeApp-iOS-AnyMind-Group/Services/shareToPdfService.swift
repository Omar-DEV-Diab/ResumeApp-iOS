//
//  shareToPdfService.swift
//  ResumeApp-iOS-AnyMind-Group
//
//  Created by Omar Diab on 2/26/22.
//

import Foundation
import UIKit

class shareToPdfService {
    static let shareSingelton = shareToPdfService()
    
    func shareResumeAsPdf(_ resume: resumeObject) -> String {
        let fmt = UIMarkupTextPrintFormatter(markupText: getDetails(resume))

        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)

        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)// A4
        render.setValue(page, forKey: "paperRect")
        render.setValue(page, forKey: "printableRect")

        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)

        for i in 0..<render.numberOfPages {
            UIGraphicsBeginPDFPage();
            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
        }

        UIGraphicsEndPDFContext();

        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(resume.ID).appendingPathExtension("pdf")
            else { fatalError("Destination URL not created") }
        
        pdfData.write(toFile: "\(documentsPath)/PDFResume.pdf", atomically: true)
        drawImageOnPDF(path: "\(documentsPath)/PDFResume.pdf", resume)
        
        return "\(documentsPath)/PDFResume.pdf"
    }
    
    func getDetails(_ resume: resumeObject) -> String {
        
        var text = """
            "<body>
                <div>
                    <h3>mobile number:\(String(describing: resume.mobile))</h3>
                        <br>
                    <h3>Email:\(String(describing: resume.Email))</h3>
                        <br>
                    <h3>Residence Area:\(String(describing: resume.area))</h3>
                        <br>
                    <h3>Totlal Years of Experiance:\(String(describing: resume.yearsOfExperience))</h3>
                        <br>
                    <h3>Email:\(String(describing: resume.getSkilsString()))</h3>
                        <br>
                    <h3>Email:\(String(describing: resume.Email))</h3>
                        <br>
                    <h3>Email:\(String(describing: resume.Email))</h3>
                        <br>
                    <h3>Email:\(String(describing: resume.Email))</h3>
                        <br>
                </div>
            </body>
        """
        
        text = text + """
                        <div>
                        <h2>Work</h2>
                        <table>
                        <tr>
                            <th>Company name </th>
                            <th>Duration</th>
                        </tr>
        """
        for work in resume.work ?? []{
            let name = work.name
            let duration = work.duration
            text = text + """
         <tr>
            <td>\(String(describing: name))</td>
            <td>\(String(describing: duration))</td>
        </tr>
        """
        }
        text = text + """
            </table>
            </div>
            """
        
        text = text + """
                        <div>
                        <h2>Education</h2>
                        <table>
                        <tr>
                            <th>Class</th>
                            <th>Year</th>
                            <th>GPA</th>
                        </tr>
        """
        for edu in resume.education ?? []{
            let name = edu.name
            let year = edu.year
            let gpa = edu.GPA
            text = text + """
         <tr>
            <td>\(String(describing: name))</td>
            <td>\(String(describing: year))</td>
            <td>\(String(describing: gpa))</td>
        </tr>
        """
        }
        text = text + """
            </table>
            </div>
            """
        
        text = text + """
                        <div>
                        <h2>Projects</h2>
                        <table>
                        <tr>
                            <th>Project name</th>
                            <th>Team size</th>
                            <th>Summary</th>
                            <th>Tech used</th>
                            <th>Role</th>
                        </tr>
        """
        for project in resume.projects ?? [] {
            let name = project.name
            let size = project.teamSize
            let summary = project.summary
            let tech = project.tech
            let role = project.role
            text = text + """
         <tr>
            <td>\(String(describing: name))</td>
            <td>\(String(describing: size))</td>
            <td>\(String(describing: summary))</td>
            <td>\(String(describing: tech))</td>
            <td>\(String(describing: role))</td>
        </tr>
        """
        }
        text = text + """
            </table>
            </div>
            """
        return text
    }
    
    func drawImageOnPDF(path: String, _ resume: resumeObject) {
        
        let pdf = CGPDFDocument(NSURL(fileURLWithPath: path))
            let pageCount = pdf?.numberOfPages
        UIGraphicsBeginPDFContextToFile(path, CGRect.zero, nil)
            for index in 1...pageCount! {
            let page =  pdf?.page(at: index)
            let pageFrame = page?.getBoxRect(.mediaBox)
            UIGraphicsBeginPDFPageWithInfo(pageFrame!, nil)
            let ctx = UIGraphicsGetCurrentContext()
            ctx?.saveGState()
            ctx?.scaleBy(x: 1, y: -1)
            ctx?.translateBy(x: 0, y: -pageFrame!.size.height)
            ctx?.drawPDFPage(page!)
            ctx?.restoreGState()
            
                if index == 1 {
                resume.getImage().draw(in: CGRect(x: 455.2, y: 40, width: 95, height: 65))
                }
            
            }
        UIGraphicsEndPDFContext()
    }
}
