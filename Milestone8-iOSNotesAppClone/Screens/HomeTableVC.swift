//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeTableVC: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    var notes = [NCNote]()
    var noteKeyCollection = [UUID]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        loadDictionary()
    }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func setNavigation()
    {
        view.backgroundColor = .systemBackground
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
    }
    
    
    @objc func editTapped()
    {
        print("edit tapped")
    }
    
    
    func loadDictionary()
    {
        // to be replaced by proper load func in persist. mgr.
        var newNote1 = NCNote(title: "new note 1", text: "a;lkdjf;aljsdf;lakjsdf;l")
        var newNote2 = NCNote(title: "new note 2", text: "a;lkdjf;aljsdf;lakjsdf;l")
        var newNote3 = NCNote(title: "new note 3", text: "a;lkdjf;aljsdf;lakjsdf;l")
        var newNote4 = NCNote(title: "new note 4", text: "a;lkdjf;aljsdf;lakjsdf;l")
        var newNote5 = NCNote(title: "new note 5", text: "a;lkdjf;aljsdf;lakjsdf;l")
        var newNote6 = NCNote(title: "new note 6", text: "a;lkdjf;aljsdf;lakjsdf;l")
        
        notes += [newNote1, newNote2, newNote3, newNote4, newNote5, newNote6]
        
        for note in notes {
            noteKeyCollection.append(note.key)
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
        var vc = NoteDetailVC(selectedNote: notes[indexPath.row])

        navigationController?.pushViewController(vc, animated: true)

    }
}
