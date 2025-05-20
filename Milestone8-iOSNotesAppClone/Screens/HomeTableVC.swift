//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeTableVC: UITableViewController, NoteDetailVCDelegate
{
    @IBOutlet var searchBar: UISearchBar!
    var notes = [NCNote]()
    var noteKeys = [String]()
    var editButton: UIBarButtonItem!
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        loadNotes()
    }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func setNavigation()
    {
        view.backgroundColor = .systemBackground
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
       
        navigationItem.rightBarButtonItems = [editButton, addButton]
    }
    
    
    @objc func editTapped()
    {
        if self.tableView.isEditing == false {
            editButton.title = "Done"
            self.tableView.isEditing = true
        } else {
            editButton.title = "Edit"
            self.tableView.isEditing = false
        }
    }
    
    
    @objc func addTapped()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            vc.delegate = self
            let newNote = NCNote(title: "", text: "")
            vc.selectedNote = newNote
            navigationController?.pushViewController(vc, animated: true)
        }
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
        let title = notes[indexPath.row].title
        cell.textLabel?.text = title == "" ? "New Note" : title
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            vc.delegate = self
            vc.selectedNote = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    // does not swipe for delete when this is grayed out
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            let note = notes[indexPath.row]
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    //-------------------------------------//
    // MARK: - NoteDetailVC Delegate Methods & LOADING
    
    func updateNotes(with thisNote: NCNote)
    {
        PersistenceManager.updateWith(note: thisNote, actionType: .add) { error in
            guard let error = error
            else { print("save successful"); return }
        }
        
        loadNotes()
        tableView.reloadData()
    }
    
    
//    func delete(note: NCNote, atIndex indexPath: IndexPath)
//    {
//        notes.removeAll{ $0.key == note.key }
//        PersistenceManager.delete(noteForKey: note.key.description)
//        notes.remove(at: indexPath.row)
//        PersistenceManager.saveAll(notes: notes)
//    }
    
//    func updateNotes(with thisNote: NCNote)
//    {
////        notes.removeAll{ $0.key == thisNote.key }
//        notes.append(thisNote)
//        
//        PersistenceManager.delete(noteForKey: thisNote.key.description)
//        PersistenceManager.save(note: thisNote)
//        PersistenceManager.saveAll(notes: notes)
//        
//        tableView.reloadData()
//    }
    
    
    
    
    
    func loadNotes()
    {
        PersistenceManager.retrieveNotes { [weak self] result in
            switch result {
            case .success(var updatedNotes):
                self?.notes = updatedNotes
            case .failure(let error):
                self?.presentNCAlertOnMainThread(alertTitle: "Load Failed", msg: MessageKeys.loadFail, btnTitle: "Ok")
            }
        }
//        notes = PersistenceManager.loadAllNotes()
    }
}
