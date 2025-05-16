//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

protocol NoteDetailVCDelegate: AnyObject {
    func updateNotes(with note: NCNote)
}

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
    var selectedNote: NCNote!
    var delegate: NoteDetailVCDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        loadText()
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
    
    
    @objc func doneTapped()
    {
        resignFirstResponder()
        saveText()
        delegate.updateNotes(with: selectedNote)
    }
    
    //-------------------------------------//
    // MARK: SAVE & LOAD
        
    @objc func saveText()
    {
        // add locked feature + mask later
        PersistenceManager.save(note: selectedNote)
        noteTextView.resignFirstResponder()
    }
    
    
    func loadText()
    {
        noteTextView.text = PersistenceManager.load(noteForKey: selectedNote.key.description)
    }
}
