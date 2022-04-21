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

        let todo = Todo(id: nil,
                        title: "good todo",
                        description: "description",
                        createdAt: Date(timeIntervalSince1970: timeStampSince1970))
        // when
        let todoView = TodoViewData(todo: todo)


        // then
        XCTAssertEqual(todoView.createdAt, dateString)
    }
}
