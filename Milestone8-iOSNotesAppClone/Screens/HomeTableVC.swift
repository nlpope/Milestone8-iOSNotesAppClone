//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeTableVC: UITableViewController, NoteDetailVCDelegate
{
    @IBOutlet var searchBar: UISearchBar!
    var notes = [NCNote]()
    var noteKeys = [String]()
    
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
    // MARK: - NoteDetailVC Delegate Methods & LOADING
    
    func updateNotes(with thisNote: NCNote)
    {
        notes.removeAll{ $0.key == thisNote.key }
        notes.append(thisNote)
        
        PersistenceManager.delete(noteForKey: thisNote.key.description)
        PersistenceManager.save(note: thisNote)
        PersistenceManager.saveAll(notes: notes)
        
        tableView.reloadData()
    }
    
    
    func loadNotes()
    {
        notes = PersistenceManager.loadAllNotes()
    }
}
