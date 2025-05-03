//  File: HomeFoldersVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/3/25.

import UIKit

class HomeFoldersVC: UITableViewController
{
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setNavigation()
    }
    
    //-------------------------------------//
    // MARK: SET UP
    
    func setNavigation()
    {
        view.backgroundColor    = .systemBackground
        title                   = "Folders"
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 3 }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        <#code#>
    }
}
