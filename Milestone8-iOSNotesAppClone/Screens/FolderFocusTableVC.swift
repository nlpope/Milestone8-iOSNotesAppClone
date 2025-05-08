//  File: FolderFocusTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class FolderFocusTableVC: UITableViewController
{
    var notes = [NCNote]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setTableView()
    }
    
    //-------------------------------------//
    // MARK: - SET UP
    
    func setTableView()
    {
        
    }

    //-------------------------------------//
    // MARK: - TABLEVIEW DELEGATE & DATASOURCE METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 0
    }
    
#warning("resign 1st responder then save using pers. mgr.")

}
