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
    @Published var rounds: Int = 3
    @Published var remainingRestTime: Int = 30
    private var restTimer: Timer?
    
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
    
    
    // Funktion auch zum Wiederholen nutzbar
    func startRestTimer() {
            remainingRestTime = 30 // Standardzeit setzen
            restTimer?.invalidate() // vorherigen Timer stoppen

            restTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                guard let self = self else { return }
                if self.remainingRestTime > 0 {
                    self.remainingRestTime -= 1
                } else {
                    self.restTimer?.invalidate()
                    self.restTimer = nil
                    // Optional: Trigger für "Restzeit vorbei"
                    print("Pause beendet!")
                }
            }
        }
        
    
        func stopRestTimer() {
            restTimer?.invalidate()
            restTimer = nil
        }
    
    
    
    
    func reset() {
        timer?.invalidate()
        isRunning = false
        elapsedTime = 0
    }
}
