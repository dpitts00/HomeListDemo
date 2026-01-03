//
//  HouseholdItemDetailsView.swift
//  HomeListDemo
//
//  Created by Daniel Pitts on 12/28/25.
//

import SwiftUI

struct HouseholdItemDetailsView: View {
    @Environment(\.dismiss) var dismiss
    
    var item: HouseholdItem
    
    @State var name: String = ""
    @State var room: SelectableValue?
    @State var user: SelectableValue?
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("Name", text: $name)
                }
                
                Section {
                    Picker("Room", selection: $room) {
                        ForEach(HouseholdItem.selectableRoomValues, id: \.self) { value in
                            Text(value.displayName)
                                .tag(value, includeOptional: true)
                        }
                    }
                    
                    Picker("User", selection: $user) {
                        ForEach(HouseholdItem.selectableUserValues, id: \.self) { value in
                            Text(value.displayName)
                                .tag(value, includeOptional: true)
                        }
                    }
                }
            }
            .task(id: item) {
                name = item.name ?? ""
                room = HouseholdItem.selectableRoomValues.first(where: { $0.rawValue == item.room })
                user = HouseholdItem.selectableUserValues.first(where: { $0.rawValue == item.user })
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(role: .destructive) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        updateItem()
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

extension HouseholdItemDetailsView {
    func updateItem() {
        item.name = name
        item.room = room?.rawValue
        item.user = user?.rawValue
        
        StorageProvider.shared.updateHouseholdItems()
    }
}

#Preview {
    @Previewable
    @State var item = StorageProvider.shared.getAllHouseholdItems()[0]
    
    HouseholdItemDetailsView(item: item)
}
