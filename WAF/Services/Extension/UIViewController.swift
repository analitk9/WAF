//
//  UIViewController.swift
//  WAF
//
//  Created by Denis Evdokimov on 11/15/22.
//

import UIKit

protocol NotificationsProtocol: AnyObject {
    func showAlert(title: String, message: String)
    
    // TODO: Добавить методы: ShowAlert and notifications
    
}


extension NotificationsProtocol where Self: UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
}
