//
//  CoreDataStackTests.swift
//  CoreDataStackTests
//
//  Created by 胡洞明 on 2021-11-22.
//

import XCTest
@testable import Data
import Domain

class CoreDataStackTests: XCTestCase {

//    let sut = CoreDataStack.test
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_persistPlacesOnBgContext_removeOldAndSaveNew() throws {
        let sut = CoreDataStack(inMemory: true)
        let bgMoc = sut.newBackgroundContext()
        let oldPlaces = Places.Place.samplePlaces
        let newPlaces = Places.Place.samplePlaces
        
        do {
            // old data
            _ = oldPlaces.map { CDPlace(context: bgMoc, domain: $0) }
            try bgMoc.saveIfNeeded()
            let result = try bgMoc.fetch(CDPlace.fetchRequest())
            
            XCTAssertEqual(oldPlaces.count, result.count)
            
            // new data
            // batch delete old
            try bgMoc.batchDeleteAndMergeChanges(fetchRequest: CDPlace.fetchRequest())
            
            // create new batch
            _ = newPlaces.map { CDPlace(context: bgMoc, domain: $0) }
            
            // save
            try bgMoc.saveIfNeeded()
            
            let newResult = try bgMoc.fetch(CDPlace.fetchRequest())
            
            XCTAssertEqual(newPlaces, newResult.compactMap{ $0.toDomain() })
        } catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
    
}

// extend so can do equal check
extension Places.Place: Identifiable, Hashable {
    
    static var samplePlaces: [Self] { (0...5).map{ _ in Self.makeRandomPlace() } }
    
    static func makeRandomPlace() -> Self {
        .init(id: UUID().uuidString,
              name: "Some Name",
              address: "Some Place",
              type: .gym,
              imageUrl: nil)
    }
    
}
