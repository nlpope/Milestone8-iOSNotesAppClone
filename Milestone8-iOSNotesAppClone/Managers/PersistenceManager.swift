//  File: PersistenceManager.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

class PersistenceManager
{
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - KEYCHAIN
        
    func save(note: NCNote)
    {
        KeychainWrapper.standard.set(note.text, forKey: note.key.description)
    }
    
    
    func load(withNoteKeys: [UUID])
    {
//        for noteKey in noteKeys {
//            note.text = KeychainWrapper.standard.string(forKey: noteKey.description) ?? ""
//        }
    }
}
