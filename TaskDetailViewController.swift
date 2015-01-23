//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by Carlos Beltran on 12/20/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import UIKit

// A view controller for our second view, the task details
class TaskDetailViewController: UIViewController {

    var taskDetailModel:TaskModel!
    
    @IBOutlet weak var taskDetailLabel: UITextField!
    @IBOutlet weak var descriptionDetailLabel: UITextField!
    @IBOutlet weak var doDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.taskDetailLabel.text = taskDetailModel.task
        self.descriptionDetailLabel.text = taskDetailModel.subTask
        
        self.doDatePicker.date = taskDetailModel.date
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication()).delegate as AppDelegate
        taskDetailModel.task = taskDetailLabel.text
        taskDetailModel.subTask = descriptionDetailLabel.text
        taskDetailModel.date = doDatePicker.date
        taskDetailModel.completed = taskDetailModel.completed
        
        appDelegate.saveContext()
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
