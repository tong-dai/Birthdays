//
//  ContentView.swift
//  Birthdays
//
//  Created by Tong Dai on 4/27/25.
//

import SwiftUI



struct ContentView: View {
    static let formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            return formatter
    }()
    
    @State private var friends: [Friend] = [
        Friend(name: "Carolyn Song", birthday: formatter.date(from:"2003/05/04") ?? Date.now),
        Friend(name: "Bonnie Dai", birthday: formatter.date(from:"1999/11/15") ?? Date.now)
    ]
    
    @State private var newName = ""
    @State private var newBirthday = Date()
    
    var body: some View {
        NavigationStack {
            List(friends, id: \.name) { friend in
                HStack {
                    Text(friend.name)
                    Spacer()
                    Text(friend.birthday, format: .dateTime.month().day().year())
                }
            }
            .navigationTitle("Birthdays")
            .safeAreaInset(edge: .bottom) {
                VStack(alignment: .center) {
                    Text("New Birthday")
                        .fontWeight(.bold)
                        .padding(10)
                        
                    DatePicker(selection: $newBirthday,
                        in: Date.distantPast...Date.now,
                        displayedComponents: .date
                    ) {
                        TextField("Name", text: $newName)
                            .textFieldStyle(PlainTextFieldStyle())
                    }
                    .padding(.horizontal, 40)
                    
                    Button("Save") {
                        let newFriend = Friend(name: newName, birthday: newBirthday)
                        friends.append(newFriend)
                        newName = ""
                        newBirthday = .now
                    }
                    .fontWeight(.bold)
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
