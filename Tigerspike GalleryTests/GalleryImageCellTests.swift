//
//  GalleryImageCellTests.swift
//  Tigerspike GalleryTests
//
//  Created by Joshua Areogun on 06/11/2017.
//  Copyright © 2017 Joshua Areogun. All rights reserved.
//

import XCTest
@testable import Tigerspike_Gallery

class GalleryImageCellTests: XCTestCase {
    
    var galleryCollectionViewCell:GalleryCollectionViewCell!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        galleryCollectionViewCell = GalleryCollectionViewCell()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetDateString(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let expectedDateString = dateFormatter.string(from:Date())
        
        let testDateString = galleryCollectionViewCell.getdateString(from: Date())
        XCTAssertEqual(testDateString, expectedDateString, "These dates don't match, have a look at your logic")
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
