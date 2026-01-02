//
//  MockHouseholdItemDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/27/25.
//

import SwiftUI

struct MockHouseholdItemDetailsView: View {
    @State var name: String = "hand soap"
    @State var room: String = "bathroom"
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $name)
            }
                     
            Section {
                Picker("Room", selection: $room) {
                    ForEach(["kitchen", "bathroom", "laundry", "medications"], id: \.self) { room in
                        Text(room)
                    }
                }
            }
        }
    }
}

#Preview {
    MockHouseholdItemDetailsView()
}
