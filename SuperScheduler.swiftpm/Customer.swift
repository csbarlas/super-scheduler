//
//  Customer.swift
//  Super Scheduler
//
//  Created by Christopher Barlas on 2/24/24.
//

import Foundation

protocol Customer {
    func runFIFOSim()
    func runSTCFSim()
    func runRRSim()
    func resetSprites()
}
