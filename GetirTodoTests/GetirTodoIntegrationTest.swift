//
//  GetirTodoIntegrationTest.swift
//  GetirTodoTests
//
//  Created by iMamad on 4/21/22.
//

import XCTest
@testable import GetirTodo


class GetirTodoIntegrationTest: XCTestCase {
    
    func testTodoViewData() {
        // given
        let timeStampSince1970 = TimeInterval("1650560539.186071")! // input
        // it shows date "2022-04-21 17:02:19 +0000"
        let dateString = "2022-04-21"                           // output
        
        let todoTitle = "good todo"
        let todo = Todo(id: nil,
                        title: todoTitle,
                        description: "description",
                        createdAt: Date(timeIntervalSince1970: timeStampSince1970))
        // when
        let todoView = TodoViewData(todo: todo)
        
        
        // then
        XCTAssertEqual(todoView.createdAt, dateString)
        XCTAssertEqual(todoView.title, todoTitle.capitalized)
    }
    
    // It uses real CoreData stack which used in app
    func testMainVM() {
        // - given - SUT
        let storage = TodoStorageManager()
        let services = Services(storage: storage)
        let mainVM = MainVM(services: services)
        // MARK: VM Test
        // - when - start
        mainVM.start()
        
        // - then -
        XCTAssertEqual(mainVM.todosContainer?.todos.count,
                       mainVM.todosContainer?.todosNSManagedObjects.count)
        XCTAssertEqual(mainVM.todos.count,
                       mainVM.todosContainer?.todosNSManagedObjects.count)
        
        // - when - save
        let todo = Todo(id: UUID().uuidString,
                        title: "test title",
                        description: "test description",
                        createdAt: Date())
        mainVM.add(todo: todo)
        // - then - save
        XCTAssertEqual(mainVM.todos.count,
                       mainVM.todosContainer?.todosNSManagedObjects.count)
        
        // - when - remove
        let lastRow = giveLastRow(mainVM: mainVM)
        mainVM.delete(index: lastRow)
        // - then - remove
        XCTAssertEqual(mainVM.todos.count,
                       mainVM.todosContainer?.todosNSManagedObjects.count)
        // - then - remove
        XCTAssertEqual(mainVM.todosContainer?.todos.count,
                       mainVM.numberOfRows())
    }
}

// MARK: Helpers
extension GetirTodoIntegrationTest {
    func giveLastRow(mainVM: MainVM) -> Int {
        IndexPath(row: (mainVM.todosContainer?.todosNSManagedObjects.count)!-1, section: 0).row
    }
}
