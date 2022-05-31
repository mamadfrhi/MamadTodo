//
//  MamadTodoTests.swift
//  MamadTodoTests
//
//  Created by iMamad on 21.12.2020.
//

import XCTest
@testable import MamadTodo

/*
 Here we avoid colliding with the app data by:
 
 - creating a new CoreDataManagerTest which sets up it's own in-memory viewContext (mainthread)
 - still doing everything on the main thread
 
 */

class MamadCoreDataTest: XCTestCase {
    
    var todoStorageManager: TodoStorageManager!
    var coreDataTESTStack: CoreDataTestStack!
    var todoObjects: [TodoObjectType] = []
    
    override func setUp() {
        super.setUp()
        coreDataTESTStack = CoreDataTestStack()
        todoStorageManager = TodoStorageManager(mainContext: coreDataTESTStack.mainContext)
        
        refreshTodoObjects()
    }
    
    func test_create_todo() {
        // given
        let todo = makeTodos().first!
        todoStorageManager.create(object: todo) { (_) in }
        
        // when
        refreshTodoObjects()
        let recentlyAddedtodo = todoObjects.last!
        // then
        XCTAssertEqual(recentlyAddedtodo.todo!.id, todo.id)
    }
    
    func test_delete_todo() {
        // given
        let threeTodos = makeTodos().sorted { $0.createdAt! < $1.createdAt! }
        _ = threeTodos.map {
            todoStorageManager.create(object: $0, completion: {_ in })
        }
        
        // when
        refreshTodoObjects()
        todoStorageManager.delete(object: todoObjects[2].todoNSManagedObject) { (_) in }
        refreshTodoObjects()
        
        // then
        todoObjects = todoObjects.sorted { $0.todo!.createdAt! < $1.todo!.createdAt! }
        XCTAssertEqual(todoObjects.count, 2)
        XCTAssertEqual(threeTodos[0].id, todoObjects[0].todo!.id)
        XCTAssertEqual(threeTodos[1].id, todoObjects[1].todo!.id)
    }
}


// MARK: Helpers
extension MamadCoreDataTest {
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
    
    private func refreshTodoObjects() {
        self.todoObjects = []
        todoStorageManager.fetch { (result) in
            let nsObjects =  try! result.get()!
            self.todoObjects.append(contentsOf: nsObjects.map { TodoObject(nsManagedObject: $0) }
            )
        }
    }
}
