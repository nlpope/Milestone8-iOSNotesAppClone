//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeTableVC: UITableViewController, UISearchBarDelegate & UISearchResultsUpdating
{
    enum Section { case main }
    
    @IBOutlet var searchBar: UISearchBar!
    var dataSource: UITableViewDiffableDataSource<Section, NCNote>!
    var notes = [NCNote]()
    var filteredNotes = [NCNote]()
    var addButton: UIBarButtonItem!
    var isSearching: Bool = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configDiffableDataSource()
        configSearchController()
    }
    
    
    override func viewWillAppear(_ animated: Bool) { loadNotes() }
    
    //-------------------------------------//
    // MARK: CONFIGURATION
    
    func configDiffableDataSource()
    {
        dataSource = UITableViewDiffableDataSource(tableView: self.tableView) { tableView, indexPath, note in
            var cell = tableView.dequeueReusableCell(withIdentifier: "NCCell")
            if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "GenericCell") }
            cell?.textLabel?.text = note.title
            
            return cell
        }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let activeArray = isSearching ? filteredNotes : notes
//        
//        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NCCell")
//        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") }
//        
//        let title = activeArray[indexPath.row].title
//        cell.textLabel?.text = title == "" ? "Untitled" : title
//        
//        return cell
//    }
    
    
    
    
    func configNavigation()
    {
        view.backgroundColor = .systemBackground
        title = "Notes"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTapped))
       
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    func configSearchController()
    {
        let mySearchController = UISearchController()
        mySearchController.searchResultsUpdater = self
        mySearchController.searchBar.delegate = self
        mySearchController.searchBar.placeholder = "Search notes"
        mySearchController.obscuresBackgroundDuringPresentation = true
        
        navigationItem.searchController = mySearchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE & DATASOURCE METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return isSearching ? filteredNotes.count : notes.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let activeArray = isSearching ? filteredNotes : notes
        
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "NCCell")
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "GenericCell") }
        
        let title = activeArray[indexPath.row].title
        cell.textLabel?.text = title == "" ? "Untitled" : title
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let activeArray = isSearching ? filteredNotes : notes
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            vc.selectedNote = activeArray[indexPath.row]
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
    
    //-------------------------------------//
    // MARK: - SEARCHING
    
    func updateUIWithSearchResults() { DispatchQueue.main.async { self.tableView.reloadData() } }
    
    
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filteredNotes = notes.filter {
            $0.title.lowercased().contains(filter.lowercased())
            || $0.text.lowercased().contains(filter.lowercased())
        }
        updateUIWithSearchResults()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        isSearching = false
        updateUIWithSearchResults()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == "" {
            updateUIWithSearchResults()
        }
    }
    
    //-------------------------------------//
    // MARK: - NAVIGATION ITEMS (ADDING NEW NOTES)
    
    @objc func addTapped()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            let newNote = NCNote(title: "", text: "")
            vc.selectedNote = newNote
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
