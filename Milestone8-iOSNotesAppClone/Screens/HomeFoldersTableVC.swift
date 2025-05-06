//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeFoldersTableVC: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var addFolderBtn: UITabBarItem!
    var sectionDictionary: [String:[String]] = [
        "": ["Quick Notes", "Shared"],
        "iCloud": ["All iCloud", "Notes"],
        "On My iPhone": ["Notes"]
    ]
    // for tupule in sortedDict: print (kind.value)
    var sortedSectionDictionaryKeys = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
        sortedSectionDictionaryKeys = Array(sectionDictionary.keys).sorted() //["","iCloud","On My iPhone"]
    }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func setNavigation()
    {
        view.backgroundColor    = .systemBackground
        title                   = "Folders"
//        let attributes = [NSAttributedString.Key.font: UIFont(name: "CaviarDreams", size: 25), NSAttributedString.Key.foregroundColor: UIColor.white]
//        self.navigationController?.navigationBar.titleTextAttributes = attributes as [NSAttributedString.Key : Any]
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE & DATASOURCE METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int { return sortedSectionDictionaryKeys.count }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header  = view as! UITableViewHeaderFooterView
        header.frame.size.width = tableView.bounds.width
        header.textLabel?.font  = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.numberOfLines = 0
        header.textLabel?.textColor = UIColor.black
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sortedSectionDictionaryKeys[section]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let currentKey      = sortedSectionDictionaryKeys[section]
        let currentValue    = sectionDictionary[currentKey]
        return currentValue?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") }
        
        cell.textLabel?.text = "testing"
        
        return cell
    }
}
