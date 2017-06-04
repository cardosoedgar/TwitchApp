//
//  UIAlertControllerExtension.swift
//  TwitchTvApp
//
//  Created by Edgar Cardoso on 04/06/17.
//  Copyright © 2017 Edgar Cardoso. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message,
                                                preferredStyle: UIAlertControllerStyle.alert)

        let okButton = UIAlertAction(title: "Ok", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
}
