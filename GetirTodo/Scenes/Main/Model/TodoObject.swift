//
//  TodoObject.swift
//  GetirTodo
//
//  Created by iMamad on 4/22/22.
//

import CoreData

protocol TodoObjectType {
    var todoNSManagedObject: NSManagedObject { get set }
    var todo: Todo? { get set}
    var todoViewData: TodoViewData? { get }
}

struct TodoObject {
    private var _todoNSManagedObject: NSManagedObject!
    var todoNSManagedObject: NSManagedObject {
        set {
            _todoNSManagedObject = newValue
            fillTodoModel(from: newValue)
        }
        get { return _todoNSManagedObject }
    }
    
    var todo: Todo?
    
    var todoViewData: TodoViewData? {
        get {
            return TodoViewData(todo: todo!)
            // take care of force unwrapp
        }
    }
    
    private mutating func fillTodoModel(from nsManagedObj: NSManagedObject){
        if let id = nsManagedObj.value(forKey: "id"),
           let title = nsManagedObj.value(forKey: "title"),
           let description = nsManagedObj.value(forKey: "description_todo"),
           let createdAtObj = nsManagedObj.value(forKey: "createdAt") {
            // to string
            let id = "\(id)"
            let title = "\(title)"
            let description = "\(description)"
            // to date
            let cratedAt = createdAtObj as! Date // take care of force unwrap
            
            todo = Todo(id: id,
                        title: title,
                        description: description,
                        createdAt: cratedAt)
        }
    }
    
    
    init(nsManagedObject: NSManagedObject) {
        self.todoNSManagedObject = nsManagedObject
    }
}
