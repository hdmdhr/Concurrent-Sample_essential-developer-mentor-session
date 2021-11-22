//
//  CDPlace+CoreDataClass.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-22.
//
//

import Foundation
import CoreData
import Domain


//@objc(CDPlace)
public class CDPlace: NSManagedObject, CoreDataBridgeable {
    
    convenience required init(context moc: NSManagedObjectContext, domain d: Places.Place) {
        self.init(context: moc)
        
        self.id = d.id
        self.address = d.address
        self.name = d.name
        self.type = d.type.rawValue
        self.imageUrl = d.imageUrl
    }
    
    
    func toDomain() -> Places.Place? {
        guard let id = id,
              let name = name,
              let address = address,
              let type = type, let typeEnum = Places.TypeEnum(rawValue: type)
        else { return nil }
        
        return .init(id: id,
                     name: name,
                     address: address,
                     type: typeEnum,
                     imageUrl: imageUrl)
    }
    
    
    
}
