//  File: NCError+Utils.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/17/25.

import Foundation

enum NCError: String, Error
{
    case unableToSave = "Unable to save this note. Please try again."
    case unableToLoad = "Notes were not able to load successfully. Please try again."
    case unableToDelete = "Unable to delete this note. Please try again."
    case noNoteToSend = "There is no note to send. Please type something then try again."
}
