//
//  Untitled.swift
//  HITTimer
//
//  Created by Artur Günter on 02.04.25.
//

import SwiftUI

class ZeitViewModel: ObservableObject {
    
    @Published var isRunning: Bool = false
    @Published var timer: Timer?
    @Published var startTime: Date?
    @Published var elapsedTime: TimeInterval = 0
    
    func startStop() {
        if isRunning {
            timer?.invalidate()
            isRunning = false
            elapsedTime = Date().timeIntervalSince(startTime ?? Date())
        } else {
            startTime = Date().addingTimeInterval(-elapsedTime)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                self.elapsedTime = Date().timeIntervalSince(self.startTime ?? Date())
            }
            isRunning = true
        }
    }
    
    
    func reset() {
        timer?.invalidate()
        isRunning = false
        elapsedTime = 0
    }
}
