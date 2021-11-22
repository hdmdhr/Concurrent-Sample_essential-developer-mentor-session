//
//  UITableView+.swift
//  Core
//
//  Created by 胡洞明 on 2021-11-22.
//

import UIKit


public extension UITableView {
    
    func dequeueCell<T: UITableViewCell>(type: T.Type) -> T {
        dequeueReusableCell(withIdentifier: T.reuseIdentifier()) as! T
    }
    
}
