//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
//    var noteTextView: UITextView!
    var selectedNote: NCNote!
    
//    init(selectedNote: NCNote)
//    {
//        super.init(nibName: nil, bundle: nil)
//        self.selectedNote = selectedNote
//    }

    
//    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
//        loadText()
        noteTextView.text = PersistenceManager.load(noteForKey: selectedNote.key.description)

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
////        selectedNote.text = noteTextView.text ?? ""
//         noteTextView.text = selectedNote.text
//
//        saveText()
        print("done tapped")
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
        #warning("notTextView reading nil/crashing app")
        noteTextView.text = PersistenceManager.load(noteForKey: selectedNote.key.description)
    }
}
