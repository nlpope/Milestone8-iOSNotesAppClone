//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeTableVC: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    var notes = [NCNote]()
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
    }
    
    
    override func viewWillAppear(_ animated: Bool) { loadNotes() }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func setNavigation()
    {
        view.backgroundColor = .systemBackground
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
       
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    @objc func addTapped()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
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
            vc.selectedNote = notes[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //-------------------------------------//
    // MARK: - TABLEVIEW DELETION HANDLING
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        // delete in userdefaults
        PersistenceManager.updateWith(note: notes[indexPath.row], actionType: .remove) { [weak self] error in
            guard let error = error else {
                // delete in notes array
                self?.notes.remove(at: indexPath.row)
                // delete in UI
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self?.presentNCAlertOnMainThread(alertTitle: "Remove unsuccessful", msg: error.rawValue, btnTitle: "Ok")
        }
    }
    
    //-------------------------------------//
    // MARK: - PERSISTENCE
    
    func loadNotes()
    {
        PersistenceManager.retrieveNotes { [weak self] result in
            switch result {
            case .success(let updatedNotes):
                self?.notes = updatedNotes
                self?.tableView.reloadData()
            case .failure(let error):
                self?.presentNCAlertOnMainThread(alertTitle: "Load Failed", msg: error.rawValue, btnTitle: "Ok")
            }
        }
    }
}
