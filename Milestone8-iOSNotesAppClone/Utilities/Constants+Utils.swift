//  File: Constants+Utils.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

enum SaveKeys
{
    static let allNotes = "AllNotes"
    static let isFirstVisit = "FirstVisit"
}

enum MaskKeys
{
    static let titleMask = "Private"
    static let touchIDReason = "Your identity must first be confirmed via Touch ID. May we make this attempt now?"
}

enum MessageKeys
{
    static let removeFail = "Unable to delete this note. Please try again."
}

enum VideoKeys
{
    static let launchScreen = "LaunchScreen"
    static let playerLayerName = "PlayerLayerName"
}
