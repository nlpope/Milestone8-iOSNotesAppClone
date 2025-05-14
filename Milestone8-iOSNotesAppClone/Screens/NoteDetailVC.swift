//  File: NoteDetailVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class NoteDetailVC: UIViewController
{
    @IBOutlet var noteTextView: UITextView!
    var selectedNote: NCNote!
    
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
        selectedNote.text = noteTextView.text
        saveText()
        print("done tapped")
    }
    
    //-------------------------------------//
    // MARK: - SAVE & LOAD
    
    func saveText()
    {
        let jsonEncoder = JSONEncoder()
        if let dataToSave = try? jsonEncoder.encode(selectedNote.text) {
            let defaults = UserDefaults.standard
            defaults.set(dataToSave, forKey: selectedNote.key.description)
        } else { print("failed to save") }
    }
    
    
    func loadText()
    {
        let defaults = UserDefaults.standard
        if let dataToLoad = defaults.object(forKey: selectedNote.key.description) as? Data {
            let jsonDecoder = JSONDecoder()
            do { selectedNote.text = try jsonDecoder.decode(String.self, from: dataToLoad) }
            catch { print("failed to load") }
            noteTextView.text = selectedNote.text
        }
    }
    
    #warning("resign 1st responder then save using pers. mgr.")
}
