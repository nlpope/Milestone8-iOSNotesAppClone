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
    
    
    static func delete(noteForKey key: String)
    {
        KeychainWrapper.standard.removeObject(forKey: key)
    }
    
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - USER DEFAULTS
    
    static func saveAll(notes: [NCNote])
    {
        let jsonEncoder = JSONEncoder()
        if let encodedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(encodedData, forKey: SaveKeys.allNotes)
            #warning("replace with NCError handler in here & load func")
        } else { print("error saving all notes") }
    }
    
    
    static func loadAllNotes() -> [NCNote]
    {
        var loadedNotes = [NCNote]()
        let defaults = UserDefaults.standard
        if let dataToDecode = defaults.object(forKey: SaveKeys.allNotes) as? Data {
            let jsonDecoder = JSONDecoder()
            do { loadedNotes = try jsonDecoder.decode([NCNote].self, from: dataToDecode) }
            catch { print("error loading all notes") }
        }
        
        return loadedNotes
    }
}
