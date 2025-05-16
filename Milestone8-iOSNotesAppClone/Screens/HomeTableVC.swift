//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeTableVC: UITableViewController, NoteDetailVCDelegate
{
    @IBOutlet var searchBar: UISearchBar!
    var notes = [NCNote]()
    var noteKeys
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        loadNotes()
    }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func loadNotes()
    {
        PersistenceManager.loadAllNotes()
//        var newNote1 = NCNote(title: "new note 1", text: "note for 1")
//        var newNote2 = NCNote(title: "new note 2", text: "note for 2")
//        var newNote3 = NCNote(title: "new note 3", text: "note for 3")
//        var newNote4 = NCNote(title: "new note 4", text: "note for 4")
//        var newNote5 = NCNote(title: "new note 5", text: "note for 5")
//        var newNote6 = NCNote(title: "new note 6", text: "note for 6")
//        
//        notes += [newNote1, newNote2, newNote3, newNote4, newNote5, newNote6]
    }
    
    
    func setNavigation()
    {
        view.backgroundColor = .systemBackground
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
       
        navigationItem.rightBarButtonItems = [editButton, addButton]
    }
    
    
    @objc func editTapped()
    {
        print("edit tapped")
    }
    
    
    @objc func addTapped()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            vc.delegate = self
            var newNote = NCNote(title: "", text: "")
            vc.selectedNote = newNote
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
        var newNote = NCNote(title: "", text: "")
        
        //present instantiated storyboard vc of notedetail
        //note creation must happen from inside noteDetail?
        //..then bring the key back out here?
        //append new note in array
        //reload data in tableview
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE & DATASOURCE METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NCCell")
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") }
        
        cell.textLabel?.text = notes[indexPath.row].title
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        var vc = NoteDetailVC(selectedNote: notes[indexPath.row])
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            vc.delegate = self
            vc.selectedNote = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //-------------------------------------//
    // MARK: - NoteDetailVC Delegate Method
    
    func updateNotes(with thisNote: NCNote)
    {
        notes.removeAll{ $0.key == thisNote.key }
        notes.append(thisNote)
        
        PersistenceManager.delete(noteForKey: thisNote.key.description)
        PersistenceManager.save(note: thisNote)
        
        tableView.reloadData()
    }
}
