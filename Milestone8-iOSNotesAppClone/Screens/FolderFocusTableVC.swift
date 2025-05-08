//  File: FolderFocusTableVC.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/6/25.

import UIKit

class FolderFocusTableVC: UITableViewController
{
    var owner: NCFolder!
    var notes: [NCNote]!
    
    init(owner: NCFolder!)
    {
        super.init(nibName: nil, bundle: nil)
        self.owner = owner
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notes = owner.notes
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
