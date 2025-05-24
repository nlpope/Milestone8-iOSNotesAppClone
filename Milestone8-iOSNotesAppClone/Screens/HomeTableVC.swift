//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.
#warning("no console warnings(?) + add launch screen when done - every app from here on")
import UIKit

class HomeTableVC: UITableViewController, UISearchBarDelegate & UISearchResultsUpdating
{
    enum Section { case main }
    
    var dataSource: UITableViewDiffableDataSource<Section, NCNote>!
    var notes = [NCNote]()
    var filteredNotes = [NCNote]()
    var addButton: UIBarButtonItem!
    var isSearching: Bool = false
    
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
            var cell = tableView.dequeueReusableCell(withIdentifier: "NCCell")
            if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "GenericCell") }
            cell?.textLabel?.text = note.title == "" ? "Untitled" : note.title
            
            return cell
        }
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE METHODS
    
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
            guard let self = self else { return }
            guard let error = error else {
                // delete in notes array
                self.notes.remove(at: indexPath.row)
                self.updateSource(with: self.notes)
                // delete in UI
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentNCAlertOnMainThread(alertTitle: "Remove unsuccessful", msg: error.rawValue, btnTitle: "Ok")
        }
    }
    
    
    //-------------------------------------//
    // MARK: - SEARCHING
    
    // search bar stuff calls updatesnap&reloadUI w/out calling updateSource... why?
    // b/c you're going by the filtered notes instead of the normal 'notes' array
    // || b/c notes never changed and filtered notes did?
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let desiredFilter = searchController.searchBar.text, !desiredFilter.isEmpty else { return }
        isSearching = true
        filteredNotes = notes.filter {
            $0.title.lowercased().contains(desiredFilter.lowercased())
            || $0.text.lowercased().contains(desiredFilter.lowercased())
        }
//        updateSource(with: filteredNotes)
        updateSnapshotAndReloadUI(for: filteredNotes)
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar)
    {
        searchBar.resignFirstResponder()
        isSearching = false
        updateSnapshotAndReloadUI(for: notes)
    }

    
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
    // MARK: - PERSISTENCE & DIFFABLE DATA UPDATING
    
    
    func loadNotes()
    {
        PersistenceManager.retrieveNotes { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let notes):
                self.updateSource(with: notes)
//                self?.notes = updatedNotes
//                self?.tableView.reloadData()
            case .failure(let error):
                self.presentNCAlertOnMainThread(alertTitle: "Load Failed", msg: error.rawValue, btnTitle: "Ok")
            }
        }
    }
    
    
    // SOURCE - only used when manipulating normal notes array
    // ..which is why we don't touch this func in search related methods
    // ..that use only a separate, filtered version
    func updateSource(with notes: [NCNote])
    {
//        self.notes.removeAll()
//        self.notes.append(contentsOf: notes)
        
        self.notes = notes
        self.updateSnapshotAndReloadUI(for: self.notes)
    }
    
    
    // REFLECTION OF THE SOURCE - WHY WE KEEP EM SEPARATE
    // notice how notes could be from either normal or filtered array
    func updateSnapshotAndReloadUI(for notes: [NCNote])
    {
        // NO DELETION NECESSARY - SNAPSHOT IS NEW INSTANCE EVERY TIME
        var snapshot = NSDiffableDataSourceSnapshot<Section, NCNote>()
        
//        snapshot.deleteAllItems()

        snapshot.appendSections([.main])
        snapshot.appendItems(notes)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
}
