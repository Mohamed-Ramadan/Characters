//
//  FilterView.swift
//  Characters
//
//  Created by Mohamed Ramadan on 25/10/2024.
//

import SwiftUI
import Combine

struct FilterView: View {
    @State private var selectedStatus: String = "All"
    @State var statuses: [String] = ["Alive", "Dead", "Unknown"]
    var didChangeFilter = PassthroughSubject<String, Never>()
    
    var body: some View {
        HStack {
            HStack(spacing: 20) {
                ForEach(statuses, id: \.self) { status in
                    Button(status, action: {
                        self.selectedStatus = status
                        self.didChangeFilter.send(status.lowercased())
                    })
                    .controlSize(.regular)
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.capsule)
                    .foregroundColor(selectedStatus == status ? .blue : .gray)
                    
                }
            }
            Spacer()
        }
        
    }
}

#Preview {
    FilterView()
}
