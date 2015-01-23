//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by Carlos Beltran on 12/21/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import UIKit
import CoreData

class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var taskDatePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonTapped(sender: UIButton) {
        
        // Get access to our app delegate
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        let managedObjectContext = appDelegate.managedObjectContext
        
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        // Create an instance of our TaskModel with an initializer provided by the CoreData framework
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        task.task = taskTextField.text
        task.subTask = descriptionTextfield.text
        task.date = taskDatePicker.date
        task.completed = false
        
        appDelegate.saveContext()
        
        // Request all instances of TaskModel entity
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        
        // Execute the fetch request 'request', store what we get back in array 'results'
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        
        for res in results {
            println(res)
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
