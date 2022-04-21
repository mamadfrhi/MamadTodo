//
//  GetirTodoTests.swift
//  GetirTodoTests
//
//  Created by Umut Afacan on 21.12.2020.
//

import XCTest
@testable import GetirTodo

/*
 Here we avoid colliding with the app data by:
 
 - creating a new CoreDataManagerTest which sets up it's own in-memory viewContext (mainthread)
 - still doing everything on the main thread
 
 */

class GetirTodoTests: XCTestCase {

    var todoStorageManager: TodoStorageManager!
    var coreDataStack: CoreDataTestStack!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        todoStorageManager = TodoStorageManager(mainContext: coreDataStack.mainContext)
    }
    
    func test_create_todo() {
        // given
        let todo = Todo(id: UUID().uuidString,
                        title: "test todo title",
                        description: "wonderful description",
                        createdAt: Date())
        todoStorageManager.create(object: todo) { (_) in }
        
        // when
        todoStorageManager.fetch { (result) in
            let todos = try! result.get()!
            let todoManagedObjContainer = TodosManagedObjectsContainer(todosNSManagedObjects: todos)
            let recentlyAddedtodo = todoManagedObjContainer.todos.first!
            // then
            XCTAssertEqual(recentlyAddedtodo.id, todo.id)
        }
    }
}
