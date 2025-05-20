//  File: Constants+Utils.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

enum SaveKeys
{
    static let allNotes = "AllNotes"
}

enum MaskKeys
{
    static let titleMask = "Private"
    static let touchIDReason = "Your identity must first be confirmed via Touch ID. May we make this attempt now?"
}

enum MessageKeys
{
    static let loadFail = "Notes were not able to load successfully. Please try again."
}
