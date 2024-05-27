//
//  ReachabilityManager.swift
//  MyStarWarsApp
//
//  Created by oussema Hichri on 27/05/2024.
//

import Foundation

protocol ReachabilityManager {
    var isConnected: Bool { get }
}

final class ReachabilityManagerImpl: ReachabilityManager {
    static let shared = ReachabilityManagerImpl()
    var isConnected: Bool {
        return true
    }
}
