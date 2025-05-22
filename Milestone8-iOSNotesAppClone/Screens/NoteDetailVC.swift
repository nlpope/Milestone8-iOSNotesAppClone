//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
    var selectedNote: NCNote!
    
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
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done,
                                       target: self,
                                       action: #selector(doneTapped))
        let composeItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(composeTapped))
        
        let deleteItem = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(deleteTapped))
        deleteItem.tintColor = .systemRed
        
        let shareItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItems = [doneItem, composeItem, shareItem, deleteItem]
    }
    
    //-------------------------------------//
    // MARK: NAVIGATION ITEMS (UPDATING)
    
    @objc func deleteTapped()
    {
        let msg = "Are you sure you'd like to delete this note?"
        let action1 = UIAlertAction(title: "No", style: .default)
        
        // click handler doesn't escape so weak self need not be captured
        let action2 = UIAlertAction(title: "Yes", style: .destructive) { _ in
            PersistenceManager.updateWith(note: self.selectedNote, actionType: .remove) { [weak self] error in
                guard let error = error else {
                    
                    self?.navigationController?.popViewController(animated: true)
                    return
                }
                self?.presentNCAlertOnMainThread(alertTitle: "Deletion Failed", msg: error.rawValue, btnTitle: "Ok")
            }
        }
        
        let ac = UIAlertController(title: "Delete this note?", message: msg, preferredStyle: .alert)
        ac.addActions(action1, action2)
        present(ac, animated: true)
    }
    
    
    @objc func shareTapped()
    {
        print("share tapped")
    }
    
    
    @objc func composeTapped()
    {
        print("compose tapped")
    }
    
    
    @objc func doneTapped()
    {
        noteTextView.resignFirstResponder()
        if let noteText = noteTextView.text {
            let newLine = noteText.firstIndex(of: "\n") ?? noteText.endIndex
            let newNoteTitle = noteText[..<newLine]
            
            selectedNote.text = noteText
            selectedNote.title = String(newNoteTitle)
        }
        
        PersistenceManager.updateWith(note: selectedNote, actionType: .add) { [weak self] error in
            guard let error = error else { return }
            self?.presentNCAlertOnMainThread(alertTitle: "Update unsuccessful", msg: error.rawValue, btnTitle: "Ok")
        }
    }
}
