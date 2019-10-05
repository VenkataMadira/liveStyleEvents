//
//  LiveStyleEventsTests.swift
//  LiveStyleEventsTests
//
//  Created by Venkat Madira on 05/10/2019.
//  Copyright © 2019 Venkat Madira. All rights reserved.
//

import XCTest
@testable import LiveStyleEvents

class LiveStyleEventsTests: XCTestCase {

    var viewControllerUnderTest: ViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.viewControllerUnderTest = storyboard.instantiateViewController(withIdentifier: "viewController") as! ViewController
        self.viewControllerUnderTest.loadView()
        self.viewControllerUnderTest.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testHasATableView() {
        XCTAssertNotNil(viewControllerUnderTest.tableView)
    }

    func testTableViewHasDelegate() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.delegate)
    }
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
       
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(viewControllerUnderTest.tableView.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.numberOfSections(in:))))
        //for below test case need some sample data 
        //XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView.numberOfRows(inSection:))))
        //XCTAssertTrue(viewControllerUnderTest.responds(to: #selector(viewControllerUnderTest.tableView.cellForRow(at:))))
    }
    func testTableViewCellHasReuseIdentifier() {
        let cell = viewControllerUnderTest.tableView(viewControllerUnderTest.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? EventTableViewCell
        let actualReuseIdentifer = cell?.reuseIdentifier
        let expectedReuseIdentifier = "eventCell"
        XCTAssertEqual(actualReuseIdentifer, expectedReuseIdentifier)
    }
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
