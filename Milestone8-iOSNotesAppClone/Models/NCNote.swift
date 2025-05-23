//  File: NCNote.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

struct NCNote: Codable, Hashable
{
    var title: String
    var text: String
    var key = UUID()
    
    func hash(into hasher: inout Hasher) { hasher.combine(title) }
}
