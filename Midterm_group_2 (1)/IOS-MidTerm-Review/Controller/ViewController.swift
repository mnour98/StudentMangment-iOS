//
//  ViewController.swift
//  IOS-MidTerm-Review
//
//  Created by user203275 on 10/17/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtName : UITextField!
    
    @IBOutlet var txtPass: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    


    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Segue.toStudentList {
        
            guard let name : String = txtName.text,
            let password : String = txtPass.text
        
            // Here, we validate for login , and to show message to the user, beacuse it was showing in console
            else {
                Toast.ok(view: self, title: "Error", message: "Please, enter a valid username")
                
                return false
            }
            
             if !(name.count == 7 || name.count == 8)  {
                Toast.show(view: self, title: "Alert", message: "Sorry!, Student Number should be between 7 and 8 numbers")
                
        
                return false
            }
            else if  name != "1933176"{
                Toast.ok(view: self, title: "Error", message: "Please, Entre a valid Uasername")
                return false
                
            }
            
            else if (password != "adm123"){
                Toast.ok(view: self, title: "Error", message: "The password  is not correct")
                return false
            }
        
            
            return true
        
        }
        
        return false
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toStudentList {
        
            let studentList = (segue.destination as! StudentListViewController)
            studentList.userName = txtName.text!
            
        }
        
        
    }
   

}

