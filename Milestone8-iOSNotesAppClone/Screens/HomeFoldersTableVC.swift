//  File: HomeFoldersTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeFoldersTableVC: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var addFolderBtn: UITabBarItem!
    var sectionDictionary: [String:[NCFolder]]!
    // for tupule in sortedDict: print (kind.value)
    var sortedSectionDictionaryKeys = [String]()
    var folders: [NCFolder]!
    
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
//        var appearance = UINavigationBarAppearance()
//        appearance.titlePositionAdjustment = UIOffset(horizontal: -15, vertical: 0)
//        navigationItem.standardAppearance = appearance
//        navigationItem.compactAppearance = appearance
//        navigationItem.titl
        //---------
        view.backgroundColor = .systemBackground
        title = "Folders"
        
        let title = UILabel()
        title.text = "Folders"
        navigationController?.navigationItem.rightBarButtonItem = barbu
        
//        let spacer = UIView()
//        NSLayoutConstraint.activate([
//            spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude),
//        ])
////        let constraint = spacer.widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat.greatestFiniteMagnitude)
////        constraint.isActive = true
////        constraint.priority = .defaultLow
//        
//        let stack = UIStackView(arrangedSubviews: [title, spacer])
//        stack.axis = .horizontal
//        navigationItem.titleView = stack
    }
    
    
    func loadDictionary()
    {
        var quickNotes = NCFolder(title: "Quick Notes", notes: [])
        var sharedNotes = NCFolder(title: "Shared", notes: [])
        var iCloudNotes = NCFolder(title: "All iCloud", notes: [])
        var localNotes = NCFolder(title: "Notes", notes: [])
        
        sectionDictionary = [
            "": [quickNotes, sharedNotes],
            "iCloud": [iCloudNotes],
            "On My iPhone": [localNotes]
        ]
        
        sortedSectionDictionaryKeys = Array(sectionDictionary.keys).sorted()
    }
    
    //-------------------------------------//
    // MARK: TABLEVC DELEGATE & DATASOURCE METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int { return sortedSectionDictionaryKeys.count }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        let header  = view as! UITableViewHeaderFooterView
        header.frame.size.width = tableView.bounds.width
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.numberOfLines = 0
        header.textLabel?.textColor = UIColor.black
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return sortedSectionDictionaryKeys[section]
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let currentKey = sortedSectionDictionaryKeys[section]
        let currentValue = sectionDictionary[currentKey]
        return currentValue?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil { cell = UITableViewCell(style: .default, reuseIdentifier: "Cell") }
        
        cell.textLabel?.text = "testing"
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
//        var vc: FolderFocusTableVC!
//        for (section, folders) in sectionDictionary {
//            if section == sectionDictionary[indexPath.row].key {
//                vc = FolderFocusTableVC(owner: folders[indexPath.row])
//
//            }
//        }
//        present(vc, animated: true)
    }
}
