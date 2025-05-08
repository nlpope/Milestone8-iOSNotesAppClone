//  File: PersistenceManager.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

class PersistenceManager
{
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - KEYCHAIN
    
    @objc func save(folder: String)
    {
        KeychainWrapper.standard.set(currentNote, forKey: SaveKeys.noteKey)
        secret.resignFirstResponder()
        secret.isHidden = true
        title           = SecretKeys.maskedTitle
    }
        
    @objc func save(note currentNote: String)
    {
        KeychainWrapper.standard.set(currentNote, forKey: SaveKeys.noteKey)
        secret.resignFirstResponder()
        secret.isHidden = true
        title           = SecretKeys.maskedTitle
    }
    
    
    func loadNote(noteName: String)
    {
        secret.text     = KeychainWrapper.standard.string(forKey: SecretKeys.secretMessage) ?? ""
    }
}
