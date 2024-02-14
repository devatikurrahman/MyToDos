//
//  ContentView.swift
//  MyToDos
//
//  Created by Atikur Rahman on 12/26/23.
//

import SwiftUI
import OSLog
//
//struct ToDoListViewOld: View {
//    let logger = Logger.myToDosApp
//    
//    @Environment(DataStore.self) var dataStore
//    @State private var modalType: ModalType? = nil
//    
//    var body: some View {
//        
//        @Bindable var dataStore = dataStore
//        NavigationStack {
//            List {
//                ForEach($dataStore.filteredToDos) { toDo in
//                    Button {
//                        modalType = .update(toDo)
//                    } label: {
//                        Text(toDo.name)
//                            .font(.title3)
//                            .strikethrough(toDo.completed)
//                            .foregroundColor(toDo.completed ? .green : Color(.label))
//                    }
//                }
//                .onDelete(perform: dataStore.deleteToDo.send)
//            }
//            .listStyle(InsetGroupedListStyle())
//            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text("My ToDos")
//                        .font(.largeTitle)
//                        .foregroundColor(.red)
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button() {
//                        modalType = .new
//                    } label: {
//                        Image(systemName: "plus.circle.fill")
//                    }
//                }
//            }
//        }
//        .sheet(item: $modalType) { $0 }
//        .alert(item: $dataStore.appError.value) { appError in
//            Alert(title: Text("Error"), message: Text(appError.error.localizedDescription))
//        }
//    }
//}
//
//#Preview {
//    ToDoListView()
//        .environment(DataStore())
//}
