//
//  UIViewController+Extension.swift
//  Characters
//
//  Created by Mohamed Ramadan on 20/10/2024.
//

import UIKit
 
extension UIViewController {
   func showAlert(with message: String) {
       let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
       let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
       alert.addAction(okAction)
       
       DispatchQueue.main.async {
           self.present(alert, animated: true, completion: nil)
       }
   }
}
