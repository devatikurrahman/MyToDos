//
//  ContentView.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import SwiftUI
import OSLog

struct ToDoListView: View {
    let logger = Logger.myToDosApp
    
    @EnvironmentObject var dataStore: DataStore
    @State private var modalType: ModalType? = nil
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dataStore.toDoList.value) { toDo in
                    Button {
                        modalType = .update(toDo)
                    } label: {
                        Text(toDo.name)
                            .font(.title3)
                            .strikethrough(toDo.completed)
                            .foregroundColor(toDo.completed ? .green : Color(.label))
                    }
                }
                .onDelete(perform: dataStore.deleteToDo.send)
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
        .alert(item: $dataStore.appError.value) { appError in
            Alert(title: Text("Error"), message: Text(appError.error.localizedDescription))
        }
    }
}

#Preview {
    ToDoListView()
        .environmentObject(DataStore())
}
