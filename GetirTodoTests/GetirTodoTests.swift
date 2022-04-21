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
    var todoManagedObjContainer: TodosManagedObjectsContainer!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        todoStorageManager = TodoStorageManager(mainContext: coreDataStack.mainContext)
    }
    
    func test_create_todo() {
        // given
        let todo = makeTodos().first!
        todoStorageManager.create(object: todo) { (_) in }
        
        // when
        refreshTodosContainer()
        let recentlyAddedtodo = todoManagedObjContainer.todos.last!
        // then
        XCTAssertEqual(recentlyAddedtodo.id, todo.id)
    }
    
    func test_delete_todo() {
        // given
        let threeTodos = makeTodos().sorted { $0.createdAt! < $1.createdAt! }
        _ = threeTodos.map {
            todoStorageManager.create(object: $0) { (_) in }
        }
        
        // when
        refreshTodosContainer()
        let lastTodoManagedObject = todoManagedObjContainer.todosNSManagedObjects.last!
        todoStorageManager.delete(object: lastTodoManagedObject) { (_) in }
        refreshTodosContainer()
        
        // then
        todoManagedObjContainer.todos = todoManagedObjContainer.todos.sorted { $0.createdAt! < $1.createdAt! }
        XCTAssertEqual(todoManagedObjContainer.todos.count, 2)
        XCTAssertEqual(todoManagedObjContainer.todosNSManagedObjects.count, 2)
        XCTAssertEqual(threeTodos[0].id, todoManagedObjContainer.todos[0].id)
        XCTAssertEqual(threeTodos[1].id, todoManagedObjContainer.todos[1].id)
    }
}


// MARK: Helpers
extension GetirTodoTests {
    private func makeTodos() -> [Todo] {
        let todo0 = Todo(id: UUID().uuidString,
                        title: "write raeadme.md",
                        description: "draw diagrams",
                        createdAt: Date())
        let todo1 = Todo(id: UUID().uuidString,
                        title: "write UI test",
                        description: "it's a good description.",
                        createdAt: Date())
        let todo2 = Todo(id: UUID().uuidString,
                        title: "Go shopping",
                        description: "Don't forget to bring the bag!",
                        createdAt: Date())
        return [todo0, todo1, todo2]
    }
    
    private func refreshTodosContainer() {
        todoStorageManager.fetch { (result) in
            let todos = try! result.get()!
            self.todoManagedObjContainer = TodosManagedObjectsContainer(todosNSManagedObjects: todos)
        }
    }
}

// TODO: TodoManagedObjectContainer is tighly coupled
// think about an alternative
