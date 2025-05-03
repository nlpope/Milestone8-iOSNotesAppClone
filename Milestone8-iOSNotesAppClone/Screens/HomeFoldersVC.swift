//  File: HomeFoldersVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeFoldersVC: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var addFolderBtn: UITabBarItem!
    var sectionDictionary: Dictionary = [
        "": ["Quick Notes", "Shared"],
        "iCloud": ["All iCloud", "Notes"],
        "On My iPhone": ["Notes"]
    ]
    var sectionDictKeys: Dictionary<String,[String]>.Keys!
    var sectionDictVals: Dictionary<String,[String]>.Values!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        sectionDictKeys = sectionDictionary.keys
        sectionDictVals = sectionDictionary.values
    }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func setNavigation()
    {
        view.backgroundColor    = .systemBackground
        title                   = "Folders"
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE & DATASOURCE METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int { return sectionDictKeys.count }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return sectionDictVals.count }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") }
        
        cell.textLabel?.text    = "testing"
        
        return cell
    }
    
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sectionDictKeys[section]
//    }
}
