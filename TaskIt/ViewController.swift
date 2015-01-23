//
//  ViewController.swift
//  TaskIt
//
//  Created by Carlos Beltran on 12/19/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // Gives us access to this application's App Delegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    // A Controller for our fetched results, update our table view with these entities
    var fetchResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    
    // Task are created, added to the global var taskArray
    // Looks like the major function of any project is declared within viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        fetchResultsController = getFetchedResultsController()
        
        fetchResultsController.delegate = self
        
        fetchResultsController.performFetch(nil) // Everything is setup, so perform the fetch
        
    }
    
    // This function gets called before the new view gets loaded onto the screen
    // If there are multiple segues, they each call this function
    // So, we want to do a check to make sure we do the proper action on the proper segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTaskDetail" {
            // Gives us access to the next view controller, and we know it's a TaskViewController
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisTask = fetchResultsController.objectAtIndexPath(indexPath!) as TaskModel
            detailVC.taskDetailModel = thisTask
        }
        else if segue.identifier == "showAddTask" {
            let addVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
        }
    }
    
    @IBAction func addTaskButtonTappd(sender: UIBarButtonItem) {
        performSegueWithIdentifier("showAddTask", sender: self)
    }
    
    // This function is called whenever this view is loaded. This view controller calls viewDidLoad() 
    // when it is first loaded, but it calls viewDidAppear() every time it is loaded, so we'll reload the data
    // on the table
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // UITableViewDataSource - I guess functions that are needed so that we have SOME functionality of
    // retrieving data from the table
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchResultsController.sections!.count
    }
    
    // Returns the number of rows at this section
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections![section].numberOfObjects
    }
    
    // Returns a reusable cell that is specified as 'myCell'
    // It's memory efficient
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        var task = fetchResultsController.objectAtIndexPath(indexPath) as TaskModel

        cell.taskLabel.text = task.task
        cell.descriptionLabel.text = task.subTask
        cell.dateLabel.text = Date.toString(date: task.date)
    
        return cell
    }

    // UITableViewDelegate - Once a row in the table is selected, we must take some
    // action, which is determined by the call to performSegueWithIdentifier
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.row)
        performSegueWithIdentifier("showTaskDetail", sender: self)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do"
        }
        else {
            return "Completed"
        }
    }
    
    // Allows for the use to swipe right and choose to delete an item. In this case, we take the
    // task being swiped on and remove it from the first section and add it to the second one.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisTask = fetchResultsController.objectAtIndexPath(indexPath) as TaskModel
        
        if indexPath.section == 0 {
            thisTask.completed = true
        }
        else {
            thisTask.completed = false
        }
        
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
    }
    
    // NSFetchResultsControllerDelegate
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    } 
    
    // Request all our enities sorted by date, return the request
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "TaskModel")
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        
        let completedSortDescriptor = NSSortDescriptor(key: "completed", ascending: true)
        
        fetchRequest.sortDescriptors = [completedSortDescriptor, sortDescriptor]
        return fetchRequest
    }
    
    // Is in charge of creating this controller that we need for fetching these entities
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        
        return fetchResultsController
    }
    
}

