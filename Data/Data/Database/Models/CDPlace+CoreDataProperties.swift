//
//  CDPlace+CoreDataProperties.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-22.
//
//

import Foundation
import CoreData


extension CDPlace {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPlace> {
        return NSFetchRequest<CDPlace>(entityName: "CDPlace")
    }

    @NSManaged public var address: String?
    @NSManaged public var id: String?
    @NSManaged public var imageUrl: URL?
    @NSManaged public var name: String?
    @NSManaged public var type: String?

}

extension CDPlace : Identifiable {

}
