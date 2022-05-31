//
//  TodoObject.swift
//  MamadTodo
//
//  Created by iMamad on 4/22/22.
//

import CoreData

protocol TodoObjectType {
    var todoNSManagedObject: NSManagedObject { get set }
    var todo: Todo? { get }
    var todoViewData: TodoViewData? { get }
}

struct TodoObject: TodoObjectType {

    private var _todoNSManagedObject: NSManagedObject!
    var todoNSManagedObject: NSManagedObject {
        set {
            _todoNSManagedObject = newValue
            fillTodoModel(from: newValue)
        }
        get { return _todoNSManagedObject }
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
            let cratedAt = createdAtObj as! Date
            
            todo = Todo(id: id,
                        title: title,
                        description: description,
                        createdAt: cratedAt)
        }
    }
    
    var todo: Todo?
    var todoViewData: TodoViewData? { get { return TodoViewData(todo: todo!) } }
    
    
    init(nsManagedObject: NSManagedObject) { self.todoNSManagedObject = nsManagedObject }
}
