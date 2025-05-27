//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

// UITableVC's auto set the datasource & delegate props to 'self'
class HomeTableVC: UITableViewController, UISearchBarDelegate & UISearchResultsUpdating
{
    enum Section { case main }
    
    var dataSource: UITableViewDiffableDataSource<Section, NCNote>!
    var notes = [NCNote]()
    var filteredNotes = [NCNote]()
    var addButton: UIBarButtonItem!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        configNavigation()
        configSearchController()
        configDiffableDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) { loadNotes() }
    
    //-------------------------------------//
    // MARK: CONFIGURATION

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
    
    
    func configDiffableDataSource()
    {
        dataSource = UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, note in
            let cell = tableView.dequeueReusableCell(withIdentifier: "NCCell", for: indexPath)
            cell.textLabel?.text = note.title == "" ? "Untitled" : note.title
            return cell
        }
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE METHODS
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let note = dataSource.itemIdentifier(for: indexPath) else { return }
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            vc.selectedNote = note
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //-------------------------------------//
    // MARK: - SEARCHING
    
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let desiredFilter = searchController.searchBar.text, !desiredFilter.isEmpty else { return }
        filteredNotes = notes.filter {
            $0.title.lowercased().contains(desiredFilter.lowercased())
            || $0.text.lowercased().contains(desiredFilter.lowercased())
        }
        updateDataSource(with: filteredNotes)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    { searchBar.resignFirstResponder(); updateDataSource(with: notes) }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    { if searchText == "" { updateDataSource(with: notes) } }

    //-------------------------------------//
    // MARK: - ADDING NEW NOTES
    
    @objc func addTapped()
    {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailVC {
            let newNote = NCNote(title: "", text: "")
            vc.selectedNote = newNote
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //-------------------------------------//
    // MARK: - PERSISTENCE & DIFFABLE DATA UPDATES
    
    func loadNotes()
    {
        PersistenceManager.retrieveNotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let notes):
                self.notes = notes
                self.updateDataSource(with: notes)
            case .failure(let error):
                self.presentNCAlertOnMainThread(alertTitle: "Load Failed", msg: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    
    func updateDataSource(with notes: [NCNote])
    {
        var snapshot = NSDiffableDataSourceSnapshot<Section, NCNote>()
        snapshot.appendSections([.main])
        snapshot.appendItems(notes)
        
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
