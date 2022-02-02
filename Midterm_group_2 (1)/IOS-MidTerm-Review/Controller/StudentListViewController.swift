//
//  StudentListViewController.swift
//  IOS-MidTerm-Review
//
//  Created by user203275 on 10/17/21.
//

import UIKit

class StudentListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewRefresh {
    

    public var userName : String = ""
    private var selectedRow : Int = -1
    
    @IBOutlet weak var lblUsername : UILabel!
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblUsername.text = "Hello \(userName)"
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return StudentProvider.allStudents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //Here,I changed to getName, beacuse it was showing email instaed of name in the list of the table
        cell.textLabel?.text = StudentProvider.allStudents[indexPath.row].getName()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedRow = indexPath.row

        tableView.deselectRow(at: indexPath, animated: false)
        
        performSegue(withIdentifier: Segue.toStudentInfoEditing, sender: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Segue.toStudentInfo {
            /// insert operation
            
            let studentInfo = (segue.destination as! StudentInfoViewController)
            studentInfo.delegate = self  /// deletage to auto-refresh the list (don't touch this)
            
            
            studentInfo.editMode = false
        
            return
        }
    
        if segue.identifier == Segue.toStudentInfoEditing {
            /// Update/delete operations
            
            let studentInfo = (segue.destination as! StudentInfoViewController)
            studentInfo.delegate = self /// deletage to auto-refresh the list (don't touch this)
            
            studentInfo.editMode = true
            studentInfo.selectedStudent = StudentProvider.allStudents[selectedRow]
        
        }

    }
    
    
    func refresh() {
        tableView.reloadData()
    }
    
}
