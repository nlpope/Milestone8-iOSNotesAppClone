//  File: PersistenceManager.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

class PersistenceManager
{
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - KEYCHAIN
    
    func save(folders: [NCFolder])
    {
        for folder in folders {
            KeychainWrapper.standard.set(folder.title, forKey: folder.key.description)
        }
    }
        
    func save(notes: [NCNote])
    {
        for note in notes {
            KeychainWrapper.standard.set(note.text, forKey: note.key.description)

        }
    }
    
    
    func loadfolders(completed: @escaping (Result<[NCFolder], Error>) -> Void)
    {
       
    }
    
    
    func load(note: NCNote) -> NCNote
    {
        note.text     = KeychainWrapper.standard.string(forKey: note.key.description) ?? ""
    }
}
