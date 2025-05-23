//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
    var selectedNote: NCNote!
    var noteDeleted: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        setUpKeyboardNotifications()
        noteTextView.text = selectedNote.text
    }
    
    override func viewWillDisappear(_ animated: Bool) { if !noteDeleted { doneTapped() } }
    
    //-------------------------------------//
    // MARK: - CONFIGURATION
    
    func configNavigation()
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
                    self?.noteDeleted = true
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
        guard let noteText = noteTextView.text else {
            let error = NCError.noNoteToSend
            presentNCAlertOnMainThread(alertTitle: "No note to send", msg: error.rawValue, btnTitle: "Ok")
            return
        }
        let vc = UIActivityViewController(activityItems: [noteText], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    
    @objc func composeTapped() { noteTextView.becomeFirstResponder() }
    
    
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
    
    
    //-------------------------------------//
    // MARK: - KEYBOARD SETTINGS
    
    func setUpKeyboardNotifications()
    {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc func adjustForKeyboard(notification: Notification)
    {
        let keyboardShape = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard let keyboardValue = keyboardShape as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let bottom = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        
        if notification.name == UIResponder.keyboardWillHideNotification { noteTextView.contentInset = .zero }
        else { noteTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottom, right: 0)}
        
        noteTextView.scrollIndicatorInsets = noteTextView.contentInset
        noteTextView.scrollRangeToVisible(noteTextView.selectedRange)
    }
}
