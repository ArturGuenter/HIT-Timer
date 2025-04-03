//
//  ContentView.swift
//  HITTimer
//
//  Created by Artur Günter on 02.03.25.
//

import SwiftUI

import SwiftUI

struct StopwatchView: View {
    
    @StateObject private var zeitViewmodel = ZeitViewModel()
    @State private var isRunning = false
    @State private var startTime: Date?
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?

    var formattedTime: String {
        let totalSeconds = Int(elapsedTime)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        let milliseconds = Int((elapsedTime - Double(totalSeconds)) * 100)
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }

    var body: some View {
        VStack(spacing: 40) {
            Text(formattedTime)
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .frame(width: 200, height: 100)

            HStack(spacing: 20) {
                Button(action: zeitViewmodel.startStop) {
                    Text(isRunning ? "Stop" : "Start")
                        .frame(width: 100, height: 50)
                        .background(isRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: reset) {
                    Text("Reset")
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
    }

    
    
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

    func reset() {
        timer?.invalidate()
        isRunning = false
        elapsedTime = 0
    }
}

struct ContentView: View {
    var body: some View {
        StopwatchView()
    }
}




#Preview {
    ContentView()
}
