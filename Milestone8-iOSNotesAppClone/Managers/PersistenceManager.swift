//  File: PersistenceManager.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

enum PersistenceManager
{
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - KEYCHAIN
        
    static func save(note: NCNote)
    {
        KeychainWrapper.standard.set(note.text, forKey: note.key.description)
    }
    
    
    static func load(noteForKey key: String) -> String
    {
        return KeychainWrapper.standard.string(forKey: key) ?? ""
    }
    
    
    static func loadAllNotes() -> [NCNote]
    {
        
    }
    
    
    static func delete(noteForKey key: String)
    {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
}
