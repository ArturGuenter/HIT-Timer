//
//  Untitled.swift
//  HITTimer
//
//  Created by Artur Günter on 02.04.25.
//

import SwiftUI

class ZeitViewModel: ObservableObject {
    
    
    func startStop() {
        if isRunning {
            timer?.invalidate()
            isRunning = false
            elapsedTime = Date().timeIntervalSince(startTime ?? Date())
        } else {
            startTime = Date().addingTimeInterval(-elapsedTime)
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                elapsedTime = Date().timeIntervalSince(startTime ?? Date())
            }
            isRunning = true
        }
    }
    
}
