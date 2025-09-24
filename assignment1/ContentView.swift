//
//  ContentView.swift
//  TravelJournal
//
//  Created by Bishal Paudel on 9/24/25.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - State Variables
    @State private var tripName = ""
    @State private var destination = ""
    @State private var departDate = Date()
    @State private var returnDate = Date()
    @State private var journalEntry = ""
    
    @State private var showTripSummary = false
    
    // MARK: - Validation Checks
    private var isTripNameValid: Bool { tripName.count >= 2 }
    private var isDestinationValid: Bool { destination.count >= 2 }
    private var areDatesValid: Bool { departDate <= returnDate }
    private var isJournalValid: Bool { journalEntry.count <= 250 }
    
    private var formIsValid: Bool {
        isTripNameValid && isDestinationValid && areDatesValid && isJournalValid
    }
    
    // MARK: - Reset Fields
    private func clearForm() {
        tripName = ""
        destination = ""
        departDate = Date()
        returnDate = Date()
        journalEntry = ""
    }
    
    // MARK: - Alert Text
    private var tripSummaryText: String {
        let formattedDates = formattedDateRange(start: departDate, end: returnDate)
        let days = tripLength(from: departDate, to: returnDate)
        let shortNote = journalEntry.count > 150 ? String(journalEntry.prefix(150)) + "…" : journalEntry
        
        return """
        ✈️ \(tripName) – \(destination)
        📅 \(formattedDates)
        🕒 Duration: \(days) day\(days > 1 ? "s" : "")
        📝 Notes: \(shortNote)
        """
    }
    
    var body: some View {
        NavigationView {
            Form {
                // MARK: - Trip Details Section
                Section(header: Text("Trip Details")) {
                    TextField("Trip Name", text: $tripName)
                    if !isTripNameValid {
                        Text("Trip name must be at least 2 characters.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    TextField("Destination", text: $destination)
                    if !isDestinationValid {
                        Text("Destination must be at least 2 characters.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    
                    DatePicker("Departure", selection: $departDate, displayedComponents: .date)
                    DatePicker("Return", selection: $returnDate, displayedComponents: .date)
                    if !areDatesValid {
                        Text("Return date cannot be earlier than departure.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                // MARK: - Trip Notes Section
                Section(header: Text("Trip Notes")) {
                    TextEditor(text: $journalEntry)
                        .frame(height: 120)
                    
                    HStack {
                        Spacer()
                        Text("\(journalEntry.count)/250")
                            .font(.caption)
                            .foregroundColor(journalEntry.count > 250 ? .red : .gray)
                    }
                    if !isJournalValid {
                        Text("Note can't exceed 250 characters.")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
                
                // MARK: - Action Buttons Section
                Section {
                    HStack {
                        Button("Clear") {
                            clearForm()
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button("Save Trip") {
                            showTripSummary = true
                        }
                        .disabled(!formIsValid)
                        .alert("Trip Saved!", isPresented: $showTripSummary) {
                            Button("OK", role: .cancel) { }
                        } message: {
                            Text(tripSummaryText)
                        }
                    }
                }
            }
            .navigationTitle("✈️ My Travel Log")
        }
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
