//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        
    }
    
    //-------------------------------------//
    // MARK: - SET UP
    
    func setNavigation()
    {
        let doneitem    = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self,
                                          action: #selector(done))
        navigationItem.rightBarButtonItem = doneitem
    }
    
    
    @objc func done()
    {
        
    }
    
    #warning("resign 1st responder then save using pers. mgr.")
}
