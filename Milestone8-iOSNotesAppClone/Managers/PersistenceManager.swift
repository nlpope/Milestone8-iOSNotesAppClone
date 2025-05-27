//  File: PersistenceManager.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

enum PersistenceActionType { case add, remove }

enum PersistenceManager
{
    //-------------------------------------//
    // MARK: SAVE & LOAD METHODS - KEYCHAIN
    
    static private let defaults = UserDefaults.standard
    
    static var isFirstVisitStatus: Bool = true 
    
    // the escape is what makes this cleaner
    // means I don't need to return arrays and save/load all over the place
    static func updateWith(note: NCNote, actionType: PersistenceActionType, completed: @escaping (NCError?) -> Void)
    {
        retrieveNotes { result in
            switch result {
            case .success(var notes):
                handle(actionType: actionType, onNote: note, inArray: &notes)
                completed(save(notes: notes))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    static func handle(actionType: PersistenceActionType, onNote note: NCNote, inArray notes: inout [NCNote])
    {
        switch actionType {
        case .add:
            notes.removeAll{ $0.key == note.key }
            notes.append(note)
        case .remove:
            notes.removeAll{ $0.key == note.key }
        }
    }
    
    
    static func save(firstVisitStatus: Bool)
    {
        do {
            let encoder = JSONEncoder()
            let encodedStatus = try encoder.encode(firstVisitStatus)
            defaults.set(encodedStatus, forKey: SaveKeys.isFirstVisit)
        } catch {
            print("cannot save is first visit bool")
        }
    }
    
    
    static func save(notes: [NCNote]) -> NCError?
    {
        do {
            let encoder = JSONEncoder()
            let encodedNotes = try encoder.encode(notes)
            defaults.set(encodedNotes, forKey: SaveKeys.allNotes)
            return nil
        } catch {
            return .unableToSave
        }
    }
    
    
    static func retrieveFirstVisitStatus() -> Bool
    {
        if let status = UserDefaults.value(forKey: SaveKeys.isFirstVisit) {
            return status as! Bool
        } else {
            return true
        }
    }
    

    static func retrieveNotes(completed: @escaping (Result<[NCNote],NCError>) -> Void)
    {
        guard let notesData = defaults.object(forKey: SaveKeys.allNotes) as? Data
        else { completed(.success([])); return }
        
        do {
            let decoder = JSONDecoder()
            let savedNotes = try decoder.decode([NCNote].self, from: notesData)
            completed(.success(savedNotes))
        } catch {
            completed(.failure(.unableToLoad))
        }
    }
}
