//  File: UIAlertController+Ext.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/21/25.

import UIKit

extension UIAlertController
{
    func addActions(_ actions: UIAlertAction...)
    {
        for action in actions { self.addAction(action) }
    }
}
