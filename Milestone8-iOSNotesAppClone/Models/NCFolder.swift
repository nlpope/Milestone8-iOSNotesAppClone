//  File: NCFolder.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/7/25.

import Foundation

struct NCFolder: Codable
{
    var title: String
    var notes: [NCNote]
    var key = UUID()
}
