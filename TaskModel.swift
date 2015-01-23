//
//  TaskModel.swift
//  TaskIt
//
//  Created by Carlos Beltran on 12/21/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel) // creates an objective-c bridge

class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var task: String
    @NSManaged var subTask: String

}
