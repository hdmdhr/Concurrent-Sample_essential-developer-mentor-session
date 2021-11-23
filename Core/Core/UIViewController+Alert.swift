//
//  UIViewController+Alert.swift
//  Core
//
//  Created by 胡洞明 on 2021-11-22.
//

import UIKit

public extension UIViewController {
    
    @discardableResult
    func presentAlert(title: String?,
                      message: String?,
                      style: UIAlertController.Style = .alert,
                      actions: [UIAlertAction] = [.init(title: "Cancel", style: .cancel)],
                      completion: Completion? = nil) -> UIAlertController
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        
        for action in actions {
            alert.addAction(action)
        }
        
        present(alert, animated: true, completion: completion)
        
        return alert
    }
    
}
