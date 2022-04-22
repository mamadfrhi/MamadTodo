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
    }
    
    // It uses real CoreData stack which used in app
    func testMainVM() {
        // - given - SUT
        let coreDataTestStack = CoreDataTestStack()
        let storage = TodoStorageManager(mainContext: coreDataTestStack.mainContext)
        let services = Services(storage: storage)
        let mainVM = MainVM(services: services)
        // MARK: VM Test
        // - when - start
        mainVM.start()
        
        // - then -
        XCTAssertEqual(mainVM.todoObjects?.count,
                       mainVM.numberOfRows())
        
        // - when - save
        let todo = Todo(id: UUID().uuidString,
                        title: "test title",
                        description: "test description",
                        createdAt: Date())
        mainVM.add(todo: todo)
        // - then - save
        XCTAssertEqual(mainVM.todoObjects?.count,
                       mainVM.numberOfRows())
        
        // - when - remove
        let lastRow = giveLastRow(mainVM: mainVM)
        mainVM.delete(index: lastRow)
        // - then - remove
        XCTAssertEqual(mainVM.todoObjects?.count,
                       mainVM.numberOfRows())
    }
}

// MARK: Helpers
extension GetirTodoIntegrationTest {
    func giveLastRow(mainVM: MainVM) -> Int {
        IndexPath(row: (mainVM.todoObjects!.count)-1, section: 0).row
    }
}
