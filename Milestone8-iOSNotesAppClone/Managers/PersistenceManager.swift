//  File: PersistenceManager.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

class PersistenceManager
{
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - KEYCHAIN
        
    func save(notes: [NCNote])
    {
        for note in notes {
            KeychainWrapper.standard.set(note.text, forKey: note.title)
        }
    }
    
    
    func load(notes: [NCNote])
    {
        // where is the uuid coming from to access the text @ that point?
//        note.text     = KeychainWrapper.standard.string(forKey: note.key.description) ?? ""
    }
}
