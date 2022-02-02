//
//  StudentInfoViewController.swift
//  IOS-MidTerm-Review
//
//  Created by user203275 on 10/17/21.
//

import UIKit


protocol TableViewRefresh {
    /// Protocol to auto-refresh the list - don't touch this code.
    func refresh()
}


class StudentInfoViewController: UIViewController {

    public var selectedStudent : Student?
    
    public var editMode : Bool = false
    
    var delegate : TableViewRefresh?  /// delegate to auto-refresh the list  - don't touch this code.
    
    @IBOutlet weak var txtStudentName : UITextField!
    
    @IBOutlet var txtStudentEmail: UITextField!
    
    @IBOutlet weak var btnDelete : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if editMode {
            txtStudentName.text=selectedStudent!.getName()
            txtStudentEmail.text=selectedStudent!.getEmail()
            
            title = "Showing Student"
            
            
            btnDelete.isHidden = false
           
        } else {
            btnDelete.isHidden = true
        }
                
        

    }

    
    @IBAction func btnSave(_ sender: Any) {
        
    
        

        if let studentName : String = txtStudentName.text,
        let studentEmail : String = txtStudentEmail.text
        {
            
            if studentName.count < 3 {
                print("Please, enter a student name with at least 3 chars!")
                return
            }
            

            if editMode {
                
                selectedStudent!.setName(name: studentName)
                selectedStudent!.setEmail(email: studentEmail)
                StudentProvider.updateStudent(updatedStudent: selectedStudent!)
                
            
            } else {

                let student = Student()
                

                student.setName(name: studentName)
                student.setId(id: Student.getNextId())
                student.setEmail(email: studentEmail)
                StudentProvider.addStudent(student: student)
            

            }
           
            delegate?.refresh()  /// auto-refresh the list - don't touch this code
            
            navigationController!.popViewController(animated: true)
            
            
        } else {
            print("Enter a valid name!")
        }
        
        
    }
    
    
    @IBAction func btnDeleteTouchUp(_ sender: Any) {
        
        StudentProvider.removeStudent(studentId: selectedStudent!.getId())
        let actionsheet = UIAlertController(title: "Alert", message:"Do you want to delete "+selectedStudent!.getName(), preferredStyle: UIAlertController.Style .actionSheet)
        
            actionsheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {action in
                
        }))
        
    actionsheet.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: {action in

                
                
            }))
        
        
            present(actionsheet, animated: true )
        
            
        
            
        
        
        
        delegate?.refresh()
        navigationController?.popViewController(animated: true)
    }
    


}
