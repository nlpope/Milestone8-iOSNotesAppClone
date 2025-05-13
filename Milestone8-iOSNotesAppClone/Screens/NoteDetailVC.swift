//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class NoteDetailVC: UIViewController
{
    var selectedNote: NCNote!
    @IBOutlet var noteTextView: UITextView!
    
    init(selectedNote: NCNote)
    {
        super.init(nibName: nil, bundle: nil)
        self.selectedNote = selectedNote
    }

    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        setTextView()
    }
    
    //-------------------------------------//
    // MARK: - SET UP
    
    func setNavigation()
    {
        let doneitem = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self,
                                          action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = doneitem
    }
    
    
    func setTextView()
    {
        
    }
    
    
    @objc func doneTapped()
    {
        print("done tapped")
    }
    
    #warning("resign 1st responder then save using pers. mgr.")
}
