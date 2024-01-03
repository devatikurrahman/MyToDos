//
//  ContentView.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: DataStore
    @State private var modalType: ModalType? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.toDoList) { toDo in
                    Button {
                        modalType = .update(toDo)
                    } label: {
                        Text(toDo.name)
                            .font(.title3)
                            .strikethrough(toDo.completed)
                            .foregroundColor(toDo.completed ? .green : Color(.label))
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My ToDos")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button() {
                        modalType = .new
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
                }
            }
        }
        .sheet(item: $modalType) { $0 }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataStore())
}
