//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

protocol NoteDetailVCDelegate: AnyObject { func updateNotes(with thisNote: NCNote) }

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
    var selectedNote: NCNote!
    var delegate: NoteDetailVCDelegate!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        noteTextView.text = selectedNote.text
    }
    
    override func viewWillDisappear(_ animated: Bool) { doneTapped() }
    
    //-------------------------------------//
    // MARK: - SET UP
    
    func setNavigation()
    {
        let doneitem = UIBarButtonItem(barButtonSystemItem: .done,
                                          target: self,
                                          action: #selector(doneTapped))
        navigationItem.rightBarButtonItem = doneitem
    }
    
    //-------------------------------------//
    // MARK: SAVE & LOAD
    
    @objc func doneTapped()
    {
        noteTextView.resignFirstResponder()
        if let noteText = noteTextView.text {
            let newLine = noteText.firstIndex(of: "\n") ?? noteText.endIndex
            let newNoteTitle = noteText[..<newLine]
            
            selectedNote.text = noteText
            selectedNote.title = String(newNoteTitle)
        }

        delegate.updateNotes(with: selectedNote)
    }
}
