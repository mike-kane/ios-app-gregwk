//
//  ViewStudentWorkForAssignmentViewController.swift
//  PortfolioTracker
//
//  Created by Mike Kane on 12/11/15.
//  Copyright © 2015 Mike Kane. All rights reserved.
//

import UIKit

class ViewStudentWorkForAssignmentViewController: UIViewController {

    var assignmentSelected: Assignment!
    
    var studentOwnsAssignment: Student!
    
    var photoTakingHelper: PhotoTakingHelper?
    
    @IBOutlet weak var assignmentImageView: UIImageView!
    
    @IBOutlet weak var dateAssignedLabel: UILabel!
    
    @IBOutlet weak var standardLabel: UILabel!
    
    @IBOutlet weak var meetsStandardImage: UIImageView!
    
    var imagesForAssignment: Array<UIImage> = []
    
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func getStudentWorkButtonPressed(sender: AnyObject) {
        takePhoto()
    }
    
    @IBAction func passesStandardButtonPressed(sender: AnyObject) {
        assignmentSelected.passing = !(assignmentSelected.passing)
        
        if assignmentSelected.passing == true {
            meetsStandardImage.image = UIImage(named: "GreenCheck.png")
        } else {
            meetsStandardImage.image = UIImage(named: "RedX.png")
        }
    }
    
    
    @IBAction func saveChangesButtonPressed(sender: AnyObject) {
        assignmentSelected.saveToParse()
        performSegueWithIdentifier("UnwindToStudentAssignmentsSegue", sender: nil)
        
        
    }
    
    
    func takePhoto() {
        photoTakingHelper = PhotoTakingHelper(viewController: self) { (image: UIImage?) in
            self.imagesForAssignment.append(image!)
            self.assignmentImageView.image = self.imagesForAssignment[0]
            dispatch_async(dispatch_get_main_queue()) {
                self.assignmentImageView.hidden = false
                self.assignmentImageView.setNeedsDisplay()
            }
        }
    }

    override func viewDidLoad() {
        
        
        dateAssignedLabel.text = "Date Assigned: \(assignmentSelected.dateAssigned)"
        standardLabel.text = "Standard: MA 3.4.2"
        if imagesForAssignment.count == 0 {
            assignmentImageView.hidden = true
        } else {
            assignmentImageView.hidden = false
            assignmentImageView.image = imagesForAssignment[0]
            
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "UnwindToStudentAssignmentsSegue" {
            let nextVC = segue.destinationViewController as! StudentDetailViewController
        }
    }

}
//convert image from UIimage to NSData using UIimagejpegrepresentation
//store image as PFfile.
