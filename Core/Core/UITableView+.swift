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
    
    
    func setEmptyMessage(_ message: String?) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .body)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.text = message
        label.textAlignment = .center
        
        backgroundView = UIView()
        backgroundView?.addSubview(label)
        
        guard let bg = backgroundView else { return }
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: bg.topAnchor),
            label.leadingAnchor.constraint(equalTo: bg.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: bg.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bg.bottomAnchor)
        ])
    }
    
}
