//  File: UIViewController+Ext.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/20/25.

import UIKit
import AVKit
import AVFoundation

extension UIViewController
{
    func presentNCAlertOnMainThread(alertTitle: String, msg: String, btnTitle: String)
    {
        DispatchQueue.main.async {
            let ac = UIAlertController(title: alertTitle, message: msg, preferredStyle: .alert)
            ac.modalPresentationStyle = .overFullScreen
            ac.modalTransitionStyle = .crossDissolve
            
            self.present(ac, animated: true)
        }
    }
}
