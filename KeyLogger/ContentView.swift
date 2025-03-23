//
//  ContentView.swift
//  KeyLogger
//
//  Created by Lucas Lisboa  on 3/23/25.
//


import SwiftUI

struct ContentView: View {
    @State private var events: [Event] = []
    
    var body: some View {
        NavigationView {
            List(events, id: \.timestamp) { event in
                VStack(alignment: .leading) {
                    Text("Type: \(event.type)")
                        .font(.headline)
                    Text("Timestamp: \(event.timestamp)")
                        .font(.subheadline)
                    Text("Data: \(event.data)")
                        .font(.body)
                }
                .padding()
            }
            .onAppear {
                fetchEvents()
            }
            .navigationTitle("Redis Events")
        }
    }
    
    func fetchEvents() {
        guard let url = URL(string: "http://localhost:5000/events") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error fetching events: \(error)")
                return
            }
            guard let data = data else { return }
            
            do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                DispatchQueue.main.async {
                    self.events = events
                }
            } catch {
                print("Error parsing events: \(error)")
            }
        }
        task.resume()
    }
}





#Preview {
    ContentView()
}
