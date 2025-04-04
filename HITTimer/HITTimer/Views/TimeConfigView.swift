//
//  TimeConfigView.swift
//  HITTimer
//
//  Created by Artur Günter on 04.04.25.
//

import Foundation
import SwiftUI

struct TimeConfigView: View {
    
    @ObservedObject var zeitViewmodel: ZeitViewModel
    @State private var selectedMinutesRound: Int = 0
    @State private var selectedSecondsRound: Int = 30
    @State private var selectedMinutesPause: Int = 0
    @State private var selectedSecondsPause: Int = 30
    var totalTrainingTime: Int {
            return selectedMinutesRound * 60 + selectedSecondsRound
        }
    
    var totalTrainingTimeInSeconds: Int {
        let trainingTime = selectedMinutesRound * 60 + selectedSecondsRound
        let pauseTime = selectedMinutesPause * 60 + selectedSecondsPause
        return zeitViewmodel.rounds * (trainingTime + pauseTime)
    }

    var formattedTime: String {
        let total = totalTrainingTimeInSeconds
        let hours = total / 3600
        let minutes = (total % 3600) / 60
        let seconds = total % 60
        
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
    
    
    var body: some View {
        
        VStack {
            Stepper("Rounds: \(zeitViewmodel.rounds)", value: $zeitViewmodel.rounds, in: 1...20)
                .padding()
            
            
            Text("Duration per round")
            HStack(spacing: 40) {
                            // Minuten Picker
                            Picker("Minuten", selection: $selectedMinutesRound) {
                                ForEach(0..<60) { minute in
                                    Text("\(minute) min").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                            
                            // Sekunden Picker
                            Picker("Sekunden", selection: $selectedSecondsRound) {
                                ForEach(0..<60) { second in
                                    Text("\(second) sec").tag(second)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                        }
                        
            Text("Duration Pause")
            
            HStack(spacing: 40) {
                            // Minuten Picker
                            Picker("Minuten", selection: $selectedMinutesPause) {
                                ForEach(0..<60) { minute in
                                    Text("\(minute) min").tag(minute)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                            
                            // Sekunden Picker
                            Picker("Sekunden", selection: $selectedSecondsPause) {
                                ForEach(0..<60) { second in
                                    Text("\(second) sec").tag(second)
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 100)
                        }
            
            
            Text("Duration Training: \(formattedTime) ")
                            .font(.headline)
                            .padding(.top)
            
            
            
        }
        
        
        
        
        
        
        
    }
    
    
    
}

#Preview {
    TimeConfigView(zeitViewmodel: ZeitViewModel())
}
