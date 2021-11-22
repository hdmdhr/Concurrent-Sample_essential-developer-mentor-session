//
//  CoreDataBridgeable.swift
//  Data
//
//  Created by 胡洞明 on 2021-11-20.
//

import Foundation
import CoreData


typealias CoreDataBridgeable = CoreDataConvertible & DomainConvertible

protocol CoreDataConvertible {
    associatedtype Domain
    
    init(context moc: NSManagedObjectContext, domain d: Domain)
}

protocol DomainConvertible {
    associatedtype Domain
    
    func toDomain() -> Domain?
}
