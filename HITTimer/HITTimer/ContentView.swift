//
//  ContentView.swift
//  HITTimer
//
//  Created by Artur Günter on 02.03.25.
//

import SwiftUI


struct StopwatchView: View {
    
    @StateObject private var zeitViewmodel = ZeitViewModel()
    

    var formattedTime: String {
        let totalSeconds = Int(zeitViewmodel.elapsedTime)
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    var body: some View {
        
        
        VStack(spacing: 40) {
            Text(formattedTime)
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .frame(width: 200, height: 100)

            HStack(spacing: 20) {
                Button(action: zeitViewmodel.startStop) {
                    Text(zeitViewmodel.isRunning ? "Stop" : "Start")
                        .frame(width: 100, height: 50)
                        .background(zeitViewmodel.isRunning ? Color.red : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: zeitViewmodel.reset) {
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

    
    
    

   
}

struct ContentView: View {
    var body: some View {
        StopwatchView()
    }
}




#Preview {
    ContentView()
}
