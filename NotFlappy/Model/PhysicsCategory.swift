//
//  PhysicsCategory.swift
//  NotFlappy
//
//  Created by Nick Dubauskas on 12/4/23.
//

import Foundation

struct PhysicsCategory {
    static let bird: UInt32 = 0b1
    static let ground: UInt32 = 0b10
    static let pipe: UInt32 = 0b100
    static let goal: UInt32 = 0b1000
}
