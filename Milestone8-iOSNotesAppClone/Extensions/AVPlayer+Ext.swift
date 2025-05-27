//  File: AVPlayer+Ext.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/27/25.

import Foundation
import AVFoundation

extension AVPlayer
{
    var isPlaying: Bool { return rate != 0 && error == nil }
}
